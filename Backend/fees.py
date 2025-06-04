# from flask import Blueprint, render_template, request, redirect, url_for, flash
# from datetime import datetime
# from .models import db, Fees, Student, Class

# fees_bp = Blueprint('fees', __name__, template_folder='../templates')

# @fees_bp.route('/', methods=['GET', 'POST'])
# def fees_page():
#     if request.method == 'POST':
#         try:
#             student_ID = int(request.form['student_ID'])
#             class_ID = int(request.form['class_ID'])
#             amount_paid = float(request.form['amount_paid'])
#             amount_due = float(request.form['amount_due'])
#             due_date = datetime.strptime(request.form['due_date'], '%Y-%m-%d').date()
#         except (ValueError, KeyError):
#             flash('Invalid input. Please check your entries.', 'danger')
#             return redirect(url_for('fees.fees_page'))

#         # Validate student exists and belongs to the class
#         student = Student.query.filter_by(student_ID=student_ID, class_ID=class_ID).first()
#         if not student:
#             flash('Student not found in the selected class.', 'danger')
#             return redirect(url_for('fees.fees_page'))

#         # Determine payment status
#         if amount_due <= 0:
#             payment_status = 'Paid'
#         elif amount_paid > 0:
#             payment_status = 'Pending'
#         else:
#             payment_status = 'Unpaid'

#         # Create new fee record
#         new_fee = Fees(
#             student_ID=student_ID,
#             amount_due=amount_due,
#             amount_paid=amount_paid,
#             due_date=due_date,
#             payment_status=payment_status
#         )

#         try:
#             db.session.add(new_fee)
#             db.session.commit()
#             flash('Payment recorded successfully.', 'success')
#         except Exception as e:
#             db.session.rollback()
#             flash(f'Error recording payment: {str(e)}', 'danger')

#         return redirect(url_for('fees.fees_page'))

#     # GET request - apply filters if any
#     search_course_class = request.args.get('search_course_class', '').strip()
#     search_student = request.args.get('search_student', '').strip()
#     payment_status_filter = request.args.get('payment_status', '').strip()

#     query = Fees.query.join(Fees.student).join(Student.class_rel)

#     if search_course_class:
#         query = query.filter(Class.class_name.ilike(f'%{search_course_class}%'))

#     if search_student:
#         if search_student.isdigit():
#             query = query.filter(Student.student_ID == int(search_student))
#         else:
#             search_pattern = f'%{search_student}%'
#             query = query.filter(
#                 (Student.first_name.ilike(search_pattern)) |
#                 (Student.last_name.ilike(search_pattern))
#             )

#     if payment_status_filter and payment_status_filter.lower() in ['paid', 'pending', 'unpaid']:
#         query = query.filter(Fees.payment_status.ilike(payment_status_filter))

#     fees_records = query.order_by(Fees.due_date.asc()).all()
#     pending_count = Fees.query.filter(Fees.payment_status.ilike('pending')).count()
#     classes = Class.query.order_by(Class.class_name).all()
#     students = Student.query.order_by(Student.student_ID).all() 
#     return render_template(
#         'fees.html',
#         fees=fees_records,
#         pending_count=pending_count,
#         classes=classes
#         students=students
#     )
from flask import Blueprint, render_template, request, redirect, url_for
from datetime import datetime
from .models import db, Fees, Student, Class

fees_bp = Blueprint('fees', __name__, template_folder='../templates')

@fees_bp.route('/fees', methods=['GET', 'POST'])
def fees_page():
    if request.method == 'POST':
        try:
            student_ID = int(request.form['student_ID'])
            class_ID = int(request.form['class_ID'])
            amount_paid = float(request.form['amount_paid'])
            amount_due = float(request.form['amount_due'])
            due_date = datetime.strptime(request.form['due_date'], '%Y-%m-%d').date()
        except (ValueError, KeyError):
            # flash('Invalid input. Please check your entries.', 'danger')
            return redirect(url_for('fees.fees_page'))

        # Validate student exists and belongs to the class
        student = Student.query.filter_by(student_ID=student_ID, class_ID=class_ID).first()
        if not student:
            # flash('Student not found in the selected class.', 'danger')
            return redirect(url_for('fees.fees_page'))

        # Determine payment status
        if amount_due <= 0:
            payment_status = 'Paid'
        elif amount_paid > 0:
            payment_status = 'Pending'
        else:
            payment_status = 'Unpaid'

        # Create new fee record
        new_fee = Fees(
            student_ID=student_ID,
            amount_due=amount_due,
            amount_paid=amount_paid,
            due_date=due_date,
            payment_status=payment_status
        )

        try:
            db.session.add(new_fee)
            db.session.commit()
            # flash('Payment recorded successfully.', 'success')
        except Exception as e:
            db.session.rollback()
            # flash(f'Error recording payment: {str(e)}', 'danger')

        return redirect(url_for('fees.fees_page'))

    # GET request - apply filters if any
    search_course_class = request.args.get('search_course_class', '').strip()
    search_student = request.args.get('search_student', '').strip()
    payment_status_filter = request.args.get('payment_status', '').strip()

    query = Fees.query.join(Fees.student).join(Student.class_rel)

    # ✅ UPDATED: class_ID filter
    if search_course_class.isdigit():
        query = query.filter(Student.class_ID == int(search_course_class))

    # ✅ UPDATED: student_ID filter
    if search_student.isdigit():
        query = query.filter(Student.student_ID == int(search_student))

    if payment_status_filter and payment_status_filter.lower() in ['paid', 'pending', 'unpaid']:
        query = query.filter(Fees.payment_status.ilike(payment_status_filter))

    fees_records = query.order_by(Fees.due_date.asc()).all()
    pending_count = Fees.query.filter_by(payment_status='pending').count()


    # ✅ FETCH classes and students for dropdowns
    classes = Class.query.order_by(Class.class_name).all()
    students = Student.query.order_by(Student.student_ID).all()

    return render_template(
        'fees.html',
        fees=fees_records,
        pending_count=pending_count,
        classes=classes,
        students=students  # ✅ pass to template
    )
@fees_bp.route('/edit/<int:fee_id>', methods=['GET', 'POST'])
def edit_fee(fee_id):
    fee_record = Fees.query.get_or_404(fee_id)
    classes = Class.query.order_by(Class.class_name).all()
    
    if request.method == 'POST':
        try:
            fee_record.amount_paid = float(request.form['amount_paid'])
            fee_record.amount_due = float(request.form['amount_due'])
            fee_record.due_date = datetime.strptime(request.form['due_date'], '%Y-%m-%d').date()
            
            # Update payment status based on new values
            if fee_record.amount_due <= 0:
                fee_record.payment_status = 'Paid'
            elif fee_record.amount_paid > 0:
                fee_record.payment_status = 'Pending'
            else:
                fee_record.payment_status = 'Unpaid'

            db.session.commit()
            # flash('Fee record updated successfully.', 'success')
            return redirect(url_for('fees.fees_page'))

        except Exception as e:
            db.session.rollback()
            # flash(f'Error updating fee: {str(e)}', 'danger')
            return redirect(url_for('fees.edit_fee', fee_id=fee_id))
    pending_count = Fees.query.filter_by(payment_status='pending').count()
    return render_template('edit_fee.html', fee=fee_record, classes=classes, pending_count=pending_count)
  
