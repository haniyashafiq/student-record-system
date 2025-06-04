from flask import Blueprint, render_template, request, redirect, url_for
from .models import db, Course

courses_bp = Blueprint('courses', __name__, template_folder='../templates')

@courses_bp.route("/courses")
def show_courses():
    all_courses = Course.query.all()
    return render_template("courses.html", courses=all_courses)

@courses_bp.route("/courses/add", methods=["POST"])
def add_course():
    course_name = request.form["course_name"]
    course_desc = request.form["course_desc"]

    if course_name.strip():  # Only add if not empty
        existing = Course.query.filter_by(course_name=course_name).first()
        if not existing:
            new_course = Course(course_name=course_name, course_desc=course_desc)
            db.session.add(new_course)
            db.session.commit()
    return redirect(url_for("courses.show_courses"))


@courses_bp.route("/courses/delete/<int:course_id>", methods=["POST"])
def delete_course(course_id):
    course = Course.query.get(course_id)
    if course:
        db.session.delete(course)
        db.session.commit()
    return redirect(url_for("courses.show_courses"))

@courses_bp.route("/courses/edit", methods=["POST"])
def edit_course():
    course_id = request.form["course_id"]
    new_name = request.form["course_name"]
    new_desc = request.form.get("course_desc", "")

    course = Course.query.get_or_404(course_id)
    course.course_name = new_name
    course.course_desc = new_desc
    db.session.commit()

    return redirect(url_for("courses.show_courses"))


@courses_bp.route("/courses/edit/<int:course_id>")
def edit_course_page(course_id):
    course = Course.query.get_or_404(course_id)
    return render_template("edit_course.html", course=course)




