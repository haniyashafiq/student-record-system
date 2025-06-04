from flask import Flask
from flask import Blueprint, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import traceback
from .models import db, Student, Course, Class, AcademicYear, Evaluation, EvaluationType, ClassCourse, Fees, Result, EvaluationStudentResult, Attendance, StudentAttendance
from .student import student_bp
from .attendance import attendance_bp
from .classes import classes_bp
from .courses import courses_bp
from .evaluation import evaluation_bp
from .fees import fees_bp
from .results import results_bp
from .dashboard import dashboard_bp

def create_app():
    app = Flask(__name__)
    app.secret_key = 'your-secret-key'
    app.config['SQLALCHEMY_DATABASE_URI'] = (
        "mssql+pyodbc://DESKTOP-MKB86PI/StudentRecords"
        "?driver=ODBC+Driver+17+for+SQL+Server"
        "&Trusted_Connection=yes"
    )
    app.config['DEBUG'] = True
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['PROPAGATE_EXCEPTIONS'] = True

    db.init_app(app)
    app.register_blueprint(student_bp)
    app.register_blueprint(attendance_bp)
    app.register_blueprint(classes_bp)
    app.register_blueprint(courses_bp)
    app.register_blueprint(evaluation_bp)
    app.register_blueprint(fees_bp)
    app.register_blueprint(results_bp)
    app.register_blueprint(dashboard_bp)

    @app.route('/')
    def index():
        return render_template('index.html')
    
    @app.route("/force_error")
    def force_error():
        raise RuntimeError("This is a test error to force a traceback!")


    @app.route('/dashboard')
    def dashboard():
        return render_template('dashboard.html')

    @app.route('/about')
    def about():
        return render_template('about.html')

    @app.route('/contact')
    def contact():
        return render_template('contact.html')    

    @app.route("/test_db")
    def test_db():
        from .models import AcademicYear
        result = AcademicYear.query.first()
        return f"Connected to DB! First Academic Year: {result.academic_name}" if result else "DB is connected, but no data."

 

    return app

