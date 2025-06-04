from flask import Blueprint, render_template, request, redirect, url_for, session
from .models import db, Student, Attendance, Fees, Evaluation, Class, Course
from datetime import date, timedelta

dashboard_bp = Blueprint('dashboard', __name__, template_folder='templates')

@dashboard_bp.route('/dashboard')
def dashboard():
    # Student count
    student_count = Student.query.count()

    # Gender distribution
    male_count = Student.query.filter_by(gender='Male').count()
    female_count = Student.query.filter_by(gender='Female').count()

    # Recent students
    recent_students = Student.query.order_by(Student.student_ID.desc()).limit(4).all()

    # Attendance summary (last 30 days)
    today = date.today()
    last_month = today - timedelta(days=30)

    present_count = Attendance.query.filter(
        Attendance.status == 'Present',
        Attendance.attendance_date.between(last_month, today)
    ).count()

    absent_count = Attendance.query.filter(
        Attendance.status == 'Absent',
        Attendance.attendance_date.between(last_month, today)
    ).count()

    # Total fees paid
    total_fees_paid = db.session.query(db.func.coalesce(db.func.sum(Fees.amount_paid), 0)).scalar()

    # Total fees due
    total_fees_due = db.session.query(db.func.coalesce(db.func.sum(Fees.amount_due), 0)).scalar()

    # Upcoming evaluations - due within next 30 days
    upcoming_evaluations = Evaluation.query.filter(
        Evaluation.submission_date >= today,
        Evaluation.submission_date <= today + timedelta(days=30)
    ).order_by(Evaluation.submission_date).all()

    # Total classes and courses count
    class_count = Class.query.count()
    course_count = Course.query.count()

    # ✅ Get notices from session
    recent_notices = session.get('recent_notices', [])

    return render_template(
        'dashboard.html',
        student_count=student_count,
        male_count=male_count,
        female_count=female_count,
        recent_students=recent_students,
        present_count=present_count,
        absent_count=absent_count,
        total_fees_paid=total_fees_paid,
        total_fees_due=total_fees_due,
        upcoming_evaluations=upcoming_evaluations,
        class_count=class_count,
        course_count=course_count,
        recent_notices=recent_notices  # ✅ Fix: define and pass this
    )

@dashboard_bp.route('/publish_notice', methods=['POST'])
def publish_notice():
    notice_message = request.form.get('notice_message')
    if notice_message:
        notice = {
            'message': notice_message,
            'date_posted': date.today().strftime('%Y-%m-%d')
        }
        notices = session.get('recent_notices', [])
        notices.insert(0, notice)  # Newest first
        session['recent_notices'] = notices[:5]  # Keep only 5
    return redirect(url_for('dashboard.dashboard'))
