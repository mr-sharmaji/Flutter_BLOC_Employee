import 'dart:async';
import 'employee.dart';

class EmployeeBloc {

  List<Employee> _employeeList = [
    Employee(1,"Employee One",100000.0),
    Employee(2,"Employee Two",200000.0),
    Employee(3,"Employee Three",300000.0),
    Employee(4,"Employee Four",400000.0),
    Employee(5,"Employee Five",500000.0),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncrementStremaController = StreamController<Employee>();
  final _employeeSalaryDecrementStremaController = StreamController<Employee>();

  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStremaController.sink;

  StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStremaController.sink;

  EmployeeBloc(){
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStremaController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStremaController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee){
    double salary = employee.salary;

    double incrementSalary = salary * 20/100;

    _employeeList[employee.id -1].salary = salary + incrementSalary;

    employeeListSink.add(_employeeList);
  }
  _decrementSalary(Employee employee){
    double salary = employee.salary;

    double decrementSalary = salary * 20/100;

    _employeeList[employee.id -1].salary = salary - decrementSalary;

    employeeListSink.add(_employeeList);
  }

  void dispose(){
    _employeeSalaryIncrementStremaController.close();
    _employeeSalaryDecrementStremaController.close();
    _employeeListStreamController.close();
  }
}