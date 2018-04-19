import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class FixedGridView extends BoxScrollView {

  /// A delegate that controls the layout of the children within the [GridView].
  ///
  /// The [GridView] and [GridView.custom] constructors let you specify this
  /// delegate explicitly. The other constructors create a [gridDelegate]
  /// implicitly.
  final SliverGridDelegate gridDelegate;

  /// A delegate that provides the children for the [GridView].
  ///
  /// The [GridView.custom] constructor lets you specify this delegate
  /// explicitly. The other constructors create a [childrenDelegate] that wraps
  /// the given child list.
  final SliverChildDelegate childrenDelegate;

  FixedGridView({
    Key key,
    Axis scrollDirection: Axis.vertical,
    bool reverse: false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap: false,
    EdgeInsetsGeometry padding,
    @required this.gridDelegate,
    bool addAutomaticKeepAlives: true,
    bool addRepaintBoundaries: true,
    List<Widget> children: const <Widget>[],
  }) : assert(gridDelegate != null),
        childrenDelegate = new SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
        key: key,
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
      );

  FixedGridView.count({
    Key key,
    Axis scrollDirection: Axis.vertical,
    bool reverse: false,
    ScrollController controller,
    bool primary,
    ScrollPhysics physics,
    bool shrinkWrap: false,
    EdgeInsetsGeometry padding,
    @required int crossAxisCount,
    double mainAxisSpacing: 0.0,
    double crossAxisSpacing: 0.0,
    double childAspectRatio: 1.0,
    bool addAutomaticKeepAlives: true,
    bool addRepaintBoundaries: true,
    List<Widget> children: const <Widget>[],
  })  : gridDelegate = new FixedSliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        childrenDelegate = new SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
        );

  @override
  Widget buildChildLayout(BuildContext context) {
    return new SliverGrid(delegate: childrenDelegate, gridDelegate: gridDelegate);
  }
}

class FixedSliverGridDelegateWithFixedCrossAxisCount extends SliverGridDelegateWithFixedCrossAxisCount {
  /// Creates a delegate that makes grid layouts with a fixed number of tiles in
  /// the cross axis.
  ///
  /// All of the arguments must not be null. The `mainAxisSpacing` and
  /// `crossAxisSpacing` arguments must not be negative. The `crossAxisCount`
  /// and `childAspectRatio` arguments must be greater than zero.
  const FixedSliverGridDelegateWithFixedCrossAxisCount({
    @required crossAxisCount,
    mainAxisSpacing: 0.0,
    crossAxisSpacing: 0.0,
    childAspectRatio: 1.0,
  }) : super(crossAxisSpacing: crossAxisSpacing, crossAxisCount: crossAxisCount, mainAxisSpacing: mainAxisSpacing, childAspectRatio: childAspectRatio);

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(childAspectRatio > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final double usableCrossAxisExtent = constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    final double childMainAxisExtent = (childCrossAxisExtent / childAspectRatio).roundToDouble();
    return new SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegateWithFixedCrossAxisCount oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount
        || oldDelegate.mainAxisSpacing != mainAxisSpacing
        || oldDelegate.crossAxisSpacing != crossAxisSpacing
        || oldDelegate.childAspectRatio != childAspectRatio;
  }
}