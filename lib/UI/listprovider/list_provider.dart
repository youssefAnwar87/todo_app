import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/app_user.dart';
import 'package:todo_app/models/todo_dm.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDm> todos=[];
  DateTime selectedDate = DateTime.now();

  refreshTodoList()async{
    CollectionReference<TodoDm> todosCollection =
    AppUser.collection().doc(AppUser.currenuser!.id).collection(TodoDm.collecctionName).withConverter

    // FirebaseFirestore.instance.collection(TodoDm.collecctionName).withConverter
      (
        fromFirestore: (docSnapshot,_){
          Map json = docSnapshot.data() as Map;
          TodoDm todo = TodoDm.fromJson(json);
          return todo;
        },
        toFirestore: (todoDm,_){
          return todoDm.toJson();
        }
    );
    QuerySnapshot <TodoDm> todosSnapShot = await todosCollection.orderBy("date").get();
    List<QueryDocumentSnapshot<TodoDm>>docs = todosSnapShot.docs;
    // for (int i = 0 ; i <docs.length;i++){
    //   todos.add(      docs[i].data() );
    // }
    todos = docs.map((docSnapshot){
      return docSnapshot.data();
    }).toList();

    todos = todos.where((todo) {
      if(todo.date.day !=  selectedDate.day ||
          todo.date.month !=  selectedDate.month ||
          todo.date.year !=  selectedDate.year){
        return false;
      }else{
        return true;
      }
    }).toList();
    // todos.clear();



    notifyListeners();
  }
  removeTodo(int index)async {
    String documentId = todos[index].id;

    todos.removeAt(index);
    CollectionReference todosCollection = AppUser.collection().doc(AppUser.currenuser!.id).collection(TodoDm.collecctionName);
    await todosCollection.doc(documentId).delete();
    notifyListeners();

  }

}