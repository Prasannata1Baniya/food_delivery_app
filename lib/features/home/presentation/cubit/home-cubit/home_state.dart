import 'package:equatable/equatable.dart';

class HomeState extends Equatable{
  final bool isPizza;
  final bool isBurger;
  final bool isChicken;

  const HomeState({this.isPizza=false, this.isBurger=false,this.isChicken=false});

  HomeState copyWith({
    bool? isPizza,
    bool? isBurger,
    bool? isChicken,
}){
    return HomeState(
      isPizza: isPizza?? this.isPizza,
      isBurger: isBurger??this.isBurger,
      isChicken: isBurger??this.isChicken,
    );
}

  @override
  List<Object?> get props => [isPizza,isBurger,isChicken];
}