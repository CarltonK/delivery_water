// Readme
// Changelog
// Example
// Installing
// Versions
// Scores
// Floating Action Bubble 
// Pub Pull Requests are welcome Codemagic build status

// A Flutter package to create a animated menu using a Floating Action Button.

// Showcase

// Installation 
// Just add floating_action_bubble to your pubspec.yml file

// dependencies:
//   floating_action_bubble: 1.0.9
// Example 
// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

//   Animation<double> _animation;
//   AnimationController _animationController;

//   @override
//   void initState(){
        
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 260),
//     );

//     final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
//     super.initState();


//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
      
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
//       //Init Floating Action Bubble 
//       floatingActionButton: FloatingActionBubble(
//         // Menu items
//         items: <Bubble>[

//           // Floating action menu item
//           Bubble(
//             title:"Settings",
//             iconColor :Colors.white,
//             bubbleColor : Colors.blue,
//             icon:Icons.settings,
//             titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//             },
//           ),
//           // Floating action menu item
//           Bubble(
//             title:"Profile",
//             iconColor :Colors.white,
//             bubbleColor : Colors.blue,
//             icon:Icons.people,
//             titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//             },
//           ),
//           //Floating action menu item
//           Bubble(
//             title:"Home",
//             iconColor :Colors.white,
//             bubbleColor : Colors.blue,
//             icon:Icons.home,
//             titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//             },
//           ),
//         ],

//         // animation controller
//         animation: _animation,

//         // On pressed change animation state
//         onPress: _animationController.isCompleted
//             ? _animationController.reverse
//             : _animationController.forward,
        
//         // Floating Action button Icon color
//         iconColor: Colors.blue,

//         // Flaoting Action button Icon 
//         icon: AnimatedIcons.add_event,
//       )
//     );
//   }

// }