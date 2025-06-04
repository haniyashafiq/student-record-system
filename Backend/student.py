from flask import Blueprint, render_template, request, redirect, url_for,flash
from .models import db, Student, Class, AcademicYear, Attendance, Result, Course, Evaluation

student_bp = Blueprint('student', __name__, template_folder='templates')

@student_bp.route('/students')
def student_page():
    students = Student.query.all()
    classes = Class.query.all()
    academic_years = AcademicYear.query.all()
    return render_template('student.html', allStd=students, classes=classes, academic_years=academic_years)

@student_bp.route('/add_student', methods=['POST'])
def add_student_route():
    data = request.form
    new_std = Student(
        first_name=data['first_name'],
        last_name=data['last_name'],
        gender=data['gender'],
        date_of_birth=data['date_of_birth'],
        class_ID=data['class_ID'],
        academic_year_ID=data['academic_year_ID']
    )
    db.session.add(new_std)
    db.session.commit()
    return redirect(url_for('student.student_page'))

# @student_bp.route('/edit_student/<int:student_id>')
# def edit_student(student_id):
    # Logic for editing
    # return f"Edit student {student_id}"

@student_bp.route('/edit_student/<int:student_id>', methods=['GET'])
def edit_student(student_id):
    student = Student.query.get_or_404(student_id)
    classes = Class.query.all()
    academic_years = AcademicYear.query.all()
    return render_template('edit_student.html', student=student, classes=classes, academic_years=academic_years)

@student_bp.route('/edit_student/<int:student_id>', methods=['POST'])
def update_student(student_id):
    student = Student.query.get_or_404(student_id)
    data = request.form
    student.first_name = data['first_name']
    student.last_name = data['last_name']
    student.gender = data['gender']
    student.date_of_birth = data['date_of_birth']
    student.class_ID = data['class_ID']
    student.academic_year_ID = data['academic_year_ID']

    db.session.commit()
   
    return redirect(url_for('student.student_page'))

@student_bp.route('/delete_student/<int:student_id>')
def delete_student(student_id):
    student = Student.query.get_or_404(student_id)
    db.session.delete(student)
    db.session.commit()
    return redirect(url_for('student.student_page'))
@student_bp.route('/student/<int:student_id>')
def student_profile(student_id):
    student = Student.query.get_or_404(student_id)

    # Get academic year info
    academic_year = AcademicYear.query.get(student.academic_year_ID)

    # Attendance summary
    attendance_records = Attendance.query.filter_by(student_ID=student_id).all()
    total_days = len(attendance_records)
    present_days = sum(1 for record in attendance_records if record.status.lower() == 'present')
    absent_days = total_days - present_days
    attendance_rate = round((present_days / total_days * 100), 2) if total_days > 0 else 0

    # Results summary
    # Get all results for this student, join with Evaluation for info if needed
    results = (
        db.session.query(Result, Evaluation)
        .join(Evaluation, Result.evaluation_ID == Evaluation.evaluation_ID)
        .filter(Result.student_ID == student_id)
        .all()
    )

    # results is a list of tuples (Result, Evaluation)
    # You can process it in the template or prepare a summary here

    return render_template(
        'student_profile.html',
        student=student,
        academic_year=academic_year,
        attendance_summary={
            'total_days': total_days,
            'present_days': present_days,
            'absent_days': absent_days,
            'attendance_rate': attendance_rate
        },
        results=results
    )