"""Add foreign keys

Revision ID: 329ac577aad9
Revises: 
Create Date: 2025-05-29 22:28:51.638997

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '329ac577aad9'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('EVALUATION_STUDENT_RESULT', schema=None) as batch_op:
        batch_op.alter_column('result_ID',
               existing_type=sa.INTEGER(),
               nullable=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('EVALUATION_STUDENT_RESULT', schema=None) as batch_op:
        batch_op.alter_column('result_ID',
               existing_type=sa.INTEGER(),
               nullable=False)

    # ### end Alembic commands ###
