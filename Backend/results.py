from flask import Blueprint, render_template, request, redirect, url_for
from sqlalchemy.exc import SQLAlchemyError
from .models import db, Student, Class, Course, Evaluation, Result, EvaluationType, AcademicYear

results_bp = Blueprint('results', __name__, url_prefix='/results')



def update_final_result(student_id, course_id):
    results = (
        db.session.query(Result)
        .join(Evaluation)
        .filter(Result.student_ID == student_id, Evaluation.course_ID == course_id)
        .all()
    )
    total_obtained = sum(r.marks_obtained for r in results)
    total_max = sum(r.evaluation.max_marks for r in results)
    percentage = (total_obtained / total_max) * 100 if total_max else 0
    

    
    


@results_bp.route('/add', methods=['POST'])
def add_result():
    try:
        student_id = int(request.form['student_id'])
        evaluation_id = int(request.form['evaluation_id'])
        marks_obtained = float(request.form['marks_obtained'])

        evaluation = db.session.get(Evaluation, evaluation_id)
        if not evaluation:
            return _render_results_template("Invalid evaluation selected.", "danger")
        elif marks_obtained > evaluation.max_marks:
            return _render_results_template(f"Marks cannot exceed max marks {evaluation.max_marks}.", "danger")

        

        new_result = Result(
            student_id=student_id,
            evaluation_id=evaluation_id,
            marks_obtained=marks_obtained
        )
        db.session.add(new_result)
        db.session.commit()
        update_final_result(student_id, evaluation.course_ID)
        return redirect(url_for('results.view_results'))

    except (ValueError, SQLAlchemyError) as e:
        db.session.rollback()
        return _render_results_template(f"Error adding result: {str(e)}", "danger")

@results_bp.route('/edit/<int:result_id>', methods=['POST'])
def edit_result(result_id):
    result = Result.query.get(result_id)
    if result:
        result.marks_obtained = float(request.form['marks_obtained'])
        
        db.session.commit()
        update_final_result(result.student_ID, evaluation.course_ID)
    return redirect(url_for('results.view_results'))

@results_bp.route('/delete/<int:result_id>', methods=['POST'])
def delete_result(result_id):
    result = Result.query.get(result_id)
    if result:
        db.session.delete(result)
        db.session.commit()
    return redirect(url_for('results.view_results'))


@results_bp.route('/', methods=['GET'])
def view_results():
    return _render_results_template()

def _render_results_template(message=None, message_type=None):
    results = (
        db.session.query(
            Result.result_ID.label('result_id'),
            Student.student_ID.label('student_id'),
            (Student.first_name + ' ' + Student.last_name).label('student_name'),
            Class.class_name.label('class_name'),
            EvaluationType.type_name.label('evaluation_type'),
            Course.course_name.label('course_name'),
            Result.marks_obtained,
            Evaluation.max_marks.label('total_marks'),
            AcademicYear.academic_name.label('academic_year')  
    
        )
        .join(Student, Result.student_ID == Student.student_ID)
        .join(Class, Student.class_ID == Class.class_ID)
        .join(AcademicYear, Student.academic_year_ID == AcademicYear.academic_year_ID) 
        .join(Evaluation, Result.evaluation_ID == Evaluation.evaluation_ID)
        .join(EvaluationType, Evaluation.evaluation_type_ID == EvaluationType.evaluation_type_ID)
        .join(Course, Evaluation.course_ID == Course.course_ID)
        .order_by(Student.student_ID)
        .all()
    )

    classes = db.session.query(Class).order_by(Class.class_name).all()
    courses = db.session.query(Course).order_by(Course.course_name).all()
    evaluation_types = db.session.query(EvaluationType).order_by(EvaluationType.type_name).all()
    students = db.session.query(Student).order_by(Student.first_name, Student.last_name).all()
    evaluations = (  #line99
    db.session.query(
        Evaluation.evaluation_ID,
        Evaluation.max_marks,
        EvaluationType.type_name,
        Course.course_name
    )
    .join(EvaluationType, Evaluation.evaluation_type_ID == EvaluationType.evaluation_type_ID)
    .join(Course, Evaluation.course_ID == Course.course_ID)
    .order_by(EvaluationType.type_name, Course.course_name)
    .all()
    )

    return render_template(
        'results.html',
        results=results,
        classes=classes,
        courses=courses,
        evaluation_types=evaluation_types,
        students=students,
        evaluations=evaluations,
        message=message,
        message_type=message_type
    )
