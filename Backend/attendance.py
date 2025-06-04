from flask import Blueprint, render_template, request, jsonify
from .models import db, Student, Class, Attendance
from datetime import datetime

attendance_bp = Blueprint('attendance', __name__, url_prefix='/attendance')


@attendance_bp.route('/')
def attendance_page():
    classes = Class.query.order_by(Class.class_name).all()
    return render_template('attendance.html', classes=classes)


@attendance_bp.route('/students', methods=['POST'])
def fetch_students():
    data = request.json
    class_id = data.get('class_id')

    students = Student.query.filter_by(class_ID=class_id).all()
    student_list = [{
        'student_id': s.student_ID,
        'name': f'{s.first_name} {s.last_name}',
        'class': s.class_ID
    } for s in students]

    return jsonify(student_list)


@attendance_bp.route('/submit', methods=['POST'])
def submit_attendance():
    data = request.json
    class_id = data['class_id']
    date_str = data['date']
    records = data['attendance']

    attendance_date = datetime.strptime(date_str, '%Y-%m-%d').date()

    for record in records:
        student_id = record['student_id']
        status = record['status']

        # Check if attendance already exists
        existing = Attendance.query.filter_by(
            student_ID=student_id,
            class_ID=class_id,
            attendance_date=attendance_date
        ).first()

        if existing:
            existing.status = status
        else:
            new_record = Attendance(
                student_ID=student_id,
                class_ID=class_id,
                attendance_date=attendance_date,
                status=status
            )
            db.session.add(new_record)

    db.session.commit()
    return jsonify({'message': 'Attendance recorded successfully!'})
