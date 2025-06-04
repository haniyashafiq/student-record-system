from flask import Blueprint, render_template, request, redirect, url_for
from .models import db, Evaluation, EvaluationType, Course

evaluation_bp = Blueprint('evaluation', __name__, template_folder='templates')

# Route to list all evaluations and provide course/type data for form and filter
@evaluation_bp.route('/evaluations')
def evaluations():
    evaluations = db.session.query(
        Evaluation.evaluation_ID,
        EvaluationType.type_name,
        Course.course_name,
        Evaluation.submission_date,
        Evaluation.max_marks,
        Course.course_ID
    ).join(EvaluationType, Evaluation.evaluation_type_ID == EvaluationType.evaluation_type_ID) \
     .join(Course, Evaluation.course_ID == Course.course_ID) \
     .order_by(Evaluation.evaluation_ID).all()

    courses = Course.query.order_by(Course.course_name).all()
    types = EvaluationType.query.order_by(EvaluationType.type_name).all()

    return render_template('evaluation.html', evaluations=evaluations, courses=courses, types=types)

# Route to add a new evaluation
@evaluation_bp.route('/add_evaluation', methods=['POST'])
def add_evaluation():
    type_id = request.form['evaluation_type_ID']
    course_id = request.form['course_ID']
    submission_date = request.form['submission_date']
    max_marks = request.form['max_marks']

    new_eval = Evaluation(
        evaluation_type_ID=type_id,
        course_ID=course_id,
        submission_date=submission_date,
        max_marks=max_marks
    )

    db.session.add(new_eval)
    db.session.commit()
    return redirect(url_for('evaluation.evaluations'))

# Route to edit an existing evaluation
@evaluation_bp.route('/edit_evaluation/<int:evaluation_id>', methods=['GET', 'POST'])
def edit_evaluation(evaluation_id):
    evaluation = Evaluation.query.get_or_404(evaluation_id)
    types = EvaluationType.query.all()
    courses = Course.query.all()

    if request.method == 'POST':
        evaluation.evaluation_type_ID = request.form['evaluation_type_ID']
        evaluation.course_ID = request.form['course_ID']
        evaluation.submission_date = request.form['submission_date']
        evaluation.max_marks = request.form['max_marks']

        db.session.commit()
        return redirect(url_for('evaluation.evaluations'))

    return render_template('edit_evaluation.html', evaluation=evaluation, types=types, courses=courses)

# Route to delete an evaluation
@evaluation_bp.route('/delete_evaluation/<int:evaluation_id>', methods=['POST'])
def delete_evaluation(evaluation_id):
    evaluation = Evaluation.query.get_or_404(evaluation_id)
    db.session.delete(evaluation)
    db.session.commit()
    return redirect(url_for('evaluation.evaluations'))
