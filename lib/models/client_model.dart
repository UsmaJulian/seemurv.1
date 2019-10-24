class Client {
  String uid;
  String taskdescription;
  String tasklocation;
  String taskname;
  String taskphone;
  String taskprice;
  String tasktime;
  String taskclientimage;
  String taskhomeservice;
  List taskfoods;
  String taskpayment;
  List taskservices;
  List taskplans;
  List taskfeatures;
  List taskenvironments;
  List tasktags;
  String taskoutfit;
  List taskrecommendeddishes;
  List taskfeaturedimages;
  String rating;
  String ratingcount;
  String totalrating;
  String logos;
  Client({
    this.uid,
    this.taskdescription,
    this.taskname,
    this.tasklocation,
    this.taskphone,
    this.taskprice,
    this.tasktime,
    this.taskclientimage,
    this.taskhomeservice,
    this.taskfoods,
    this.taskpayment,
    this.taskservices,
    this.taskplans,
    this.taskfeatures,
    this.taskenvironments,
    this.tasktags,
    this.taskoutfit,
    this.taskrecommendeddishes,
    this.taskfeaturedimages,
    this.rating,
    this.ratingcount,
    this.totalrating,
    this.logos,
  });
  factory Client.fromJson(Map<String, dynamic> parsedJson) {
    return Client(
      uid: parsedJson['uid'],
      logos: parsedJson['logos'],
      rating: parsedJson['rating'],
      ratingcount: parsedJson['ratingcount'],
      taskclientimage: parsedJson['taskclientimage'],
      taskdescription: parsedJson['taskdescription'],
      taskenvironments: parsedJson['taskenvironments'],
      taskfeaturedimages: parsedJson['taskfeaturedimages'],
      taskfeatures: parsedJson['taskfeatures'],
      taskfoods: parsedJson['taskfoods'],
      taskhomeservice: parsedJson['taskhomeservice'],
      tasklocation: parsedJson['tasklocation'],
      taskname: parsedJson['taskname'],
      taskoutfit: parsedJson['taskoutfit'],
      taskpayment: parsedJson['taskpayment'],
      taskphone: parsedJson['taskphone'],
      taskplans: parsedJson['taskplans'],
      taskprice: parsedJson['taskprice'],
      taskrecommendeddishes: parsedJson['taskrecommendeddishes'],
      taskservices: parsedJson['taskservices'],
      tasktags: parsedJson['tasktags'],
      tasktime: parsedJson['tasktime'],
      totalrating: parsedJson['totalrating'],
    );
  }
}
