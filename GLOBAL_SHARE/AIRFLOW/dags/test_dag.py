from airflow import DAG
import datetime

default_args = {
        'depends_on_past': False,
        'email': ['airflow@example.com'],
        'email_on_failure': False,
        'email_on_retry': False,
        'retries': 3,
        'retry_delay': datetime.timedelta(seconds=10),
        'start_date': datetime.datetime(2020, 2, 2)
    }

with DAG(
    'test_connection_dag',
    default_args = default_args,
    schedule_interval = None,
    max_active_runs = 1,
    catchup = False
) as dag:
    from airflow.providers.postgres.operators.postgres import PostgresOperator
    from airflow.operators.dummy_operator import DummyOperator
    from airflow.operators.python import PythonOperator

    sql_dwh = f'SELECT * FROM dwh.flights LIMIT 10;'
    sql_airflow = f'SELECT NOW();'

    def start_task_f():
        print('Start task')

    start_task = PythonOperator(
            task_id = 'start_task',
            dag = dag,
            python_callable = start_task_f
            )

    def end_task_f():
        print('End task')

    end_task = PythonOperator(
            task_id = 'end_task',
            dag = dag,
            python_callable = end_task_f
            )
    
    test_dwh_task = PostgresOperator(
            task_id = "test_dwh_task",
            postgres_conn_id = "dwh_postgres_connection",
            sql = sql_dwh
            )
    test_airflow_task = PostgresOperator(
            task_id = "test_airflow_task",
            postgres_conn_id = "airflow_postgres_connection",
            sql = sql_airflow
            )
    
    start_task >> test_dwh_task >> test_airflow_task >>  end_task