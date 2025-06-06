import 'fire_value.dart';

abstract class FireGuardedOperator<T> extends FireValuesContainer {
  final List<OperationGuard> guards;

  const FireGuardedOperator({
    this.guards = const [],
  });

  Future<bool> canPerform() async {
    for (var guard in guards) {
      final allow = await guard.canPerform();
      if (allow == false) return false;
    }
    return true;
  }

  Future<T?> tryPerform() async {
    final canPerformAction = await canPerform();
    if (canPerformAction) {
      return await perform();
    }
    return null;
  }

  Future<T?> perform();
}
