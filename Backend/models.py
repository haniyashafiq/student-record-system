from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class AcademicYear(db.Model):
    __tablename__ = 'ACADEMIC_YEAR'
    academic_year_ID = db.Column(db.Integer, primary_key=True)
    academic_name = db.Column(db.String(100), unique=True, nullable=False)
    students = db.relationship('Student', backref='academic_year', cascade="all, delete")

class Class(db.Model):
    __tablename__ = 'CLASS'
    class_ID = db.Column(db.Integer, primary_key=True)
    class_name = db.Column(db.String(100), unique=True, nullable=False)
    students = db.relationship('Student', backref='class_', cascade="all, delete")

class Course(db.Model):
    __tablename__ = 'COURSES'
    course_ID = db.Column(db.Integer, primary_key=True)
    course_name = db.Column(db.String(100), unique=True, nullable=False)
    course_desc = db.Column(db.String(255))
    classes = db.relationship('Class', secondary='CLASS_COURSE', backref='courses')

class EvaluationType(db.Model):
    __tablename__ = 'EVALUATION_TYPE'
    evaluation_type_ID = db.Column(db.Integer, primary_key=True)
    type_name = db.Column(db.String(100), unique=True, nullable=False)
    evaluations = db.relationship('Evaluation', backref='type', cascade="all, delete")

class Evaluation(db.Model):
    __tablename__ = 'EVALUATION'
    evaluation_ID = db.Column(db.Integer, primary_key=True)
    evaluation_type_ID = db.Column(db.Integer, db.ForeignKey('EVALUATION_TYPE.evaluation_type_ID', ondelete='CASCADE'), nullable=False)
    course_ID = db.Column(db.Integer, db.ForeignKey('COURSES.course_ID', ondelete='CASCADE'), nullable=False)
    submission_date = db.Column(db.Date, nullable=False)
    max_marks = db.Column(db.Integer, nullable=False)
    results = db.relationship('Result', backref='evaluation', cascade='all, delete-orphan')
    course = db.relationship('Course', backref='evaluations')
class ClassCourse(db.Model):
    __tablename__ = 'CLASS_COURSE'
    course_ID = db.Column(db.Integer, db.ForeignKey('COURSES.course_ID', ondelete='CASCADE'), primary_key=True)
    class_ID = db.Column(db.Integer, db.ForeignKey('CLASS.class_ID', ondelete='CASCADE'), primary_key=True)

class Student(db.Model):
    __tablename__ = 'STUDENTS'
    student_ID = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    date_of_birth = db.Column(db.Date, nullable=False)
    class_ID = db.Column(db.Integer, db.ForeignKey('CLASS.class_ID', ondelete='CASCADE'), nullable=False)
    academic_year_ID = db.Column(db.Integer, db.ForeignKey('ACADEMIC_YEAR.academic_year_ID', ondelete='CASCADE'), nullable=False)
    class_rel = db.relationship('Class', backref='student') 
    fees = db.relationship('Fees', backref='student', cascade='all, delete-orphan')
    results = db.relationship('Result', backref='student', cascade='all, delete-orphan')
    attendance_records = db.relationship('Attendance', backref='student', cascade='all, delete-orphan')

class Fees(db.Model):
    __tablename__ = 'FEES'
    fees_ID = db.Column(db.Integer, primary_key=True)
    student_ID = db.Column(db.Integer, db.ForeignKey('STUDENTS.student_ID', ondelete='CASCADE'), nullable=False)
    amount_due = db.Column(db.Numeric(10, 2), nullable=False)
    amount_paid = db.Column(db.Numeric(10, 2), nullable=False)
    due_date = db.Column(db.Date, nullable=False)
    payment_status = db.Column(db.String(20), nullable=False, default='Pending')
   
class Result(db.Model):
    __tablename__ = 'RESULTS'
    result_ID = db.Column(db.Integer, primary_key=True)
    student_ID = db.Column(db.Integer, db.ForeignKey('STUDENTS.student_ID', ondelete='CASCADE'), nullable=False)
    evaluation_ID = db.Column(db.Integer, db.ForeignKey('EVALUATION.evaluation_ID', ondelete='CASCADE'), nullable=False)
    marks_obtained = db.Column(db.Integer, nullable=False)
    


class EvaluationStudentResult(db.Model):
    __tablename__ = 'EVALUATION_STUDENT_RESULT'
    evaluation_ID = db.Column(db.Integer, db.ForeignKey('EVALUATION.evaluation_ID', ondelete='CASCADE'), primary_key=True)
    student_ID = db.Column(db.Integer, db.ForeignKey('STUDENTS.student_ID', ondelete='CASCADE'), primary_key=True)
    result_ID = db.Column(db.Integer, db.ForeignKey('RESULTS.result_ID'))

class Attendance(db.Model):
    __tablename__ = 'ATTENDANCE'
    attendance_ID = db.Column(db.Integer, primary_key=True)
    student_ID = db.Column(db.Integer, db.ForeignKey('STUDENTS.student_ID', ondelete='CASCADE'), nullable=False)
    class_ID = db.Column(db.Integer, db.ForeignKey('CLASS.class_ID'), nullable=False)
    attendance_date = db.Column(db.Date, nullable=False)
    status = db.Column(db.String(20), nullable=False, default='Present')

class StudentAttendance(db.Model):
    __tablename__ = 'STUDENT_ATTENDANCE'
    attendance_ID = db.Column(db.Integer, db.ForeignKey('ATTENDANCE.attendance_ID', ondelete='CASCADE'), primary_key=True)
    student_ID = db.Column(db.Integer, db.ForeignKey('STUDENTS.student_ID'), primary_key=True)

# class FinalResult(db.Model):
#     __tablename__ = 'FINAL_RESULTS'

#     id = db.Column(db.Integer, primary_key=True)
#     student_ID = db.Column(db.Integer, db.ForeignKey('STUDENTS.student_ID', ondelete='CASCADE'), nullable=False)
#     course_ID = db.Column(db.Integer, db.ForeignKey('COURSES.course_ID', ondelete='CASCADE'), nullable=False)
#     total_marks = db.Column(db.Float, nullable=False)
#     max_marks = db.Column(db.Float, nullable=False)
#     percentage = db.Column(db.Float, nullable=False)
#     grade = db.Column(db.String(2), nullable=False)

#     student = db.relationship('Student', backref='final_results')
#     course = db.relationship('Course', backref='final_results')