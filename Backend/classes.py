from flask import Blueprint, render_template, request, redirect, url_for
from .models import db, Class, Course, ClassCourse

classes_bp = Blueprint('classes', __name__, template_folder='../templates')

@classes_bp.route("/classes")
def show_class_course():
    data = db.session.query(
        Class.class_ID, Class.class_name, Course.course_ID, Course.course_name
    ).join(ClassCourse, Class.class_ID == ClassCourse.class_ID) \
     .join(Course, Course.course_ID == ClassCourse.course_ID) \
     .all()

    class_data = [
        {
            "class_id": c[0],
            "class_name": c[1],
            "course_id": c[2],
            "course_name": c[3]
        }
        for c in data
    ]

    classes = Class.query.all()
    courses = Course.query.all()

    return render_template("classes_courses.html", class_data=class_data, classes=classes, courses=courses)

@classes_bp.route("/classes/add", methods=["POST"])
def add_class_course():
    class_id = request.form["class_id"]
    course_id = request.form["course_id"]

    existing = ClassCourse.query.filter_by(class_ID=class_id, course_ID=course_id).first()
    if not existing:
        association = ClassCourse(class_ID=class_id, course_ID=course_id)
        db.session.add(association)
        db.session.commit()

    return redirect(url_for("classes.show_class_course"))

@classes_bp.route("/classes/delete/<int:class_id>/<int:course_id>", methods=["POST"])
def delete_class_course(class_id, course_id):
    association = ClassCourse.query.filter_by(class_ID=class_id, course_ID=course_id).first()
    if association:
        db.session.delete(association)
        db.session.commit()

    return redirect(url_for("classes.show_class_course"))
