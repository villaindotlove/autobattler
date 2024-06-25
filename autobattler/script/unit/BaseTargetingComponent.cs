using System.Collections.Generic;
using System.Linq;
using Godot;

public partial class BaseTargetingComponent : Node, IAutoComponent
{
    private IAutomaton _parentUnit;
    private IAutomaton _target;

    public void SetParentUnit(IAutomaton unit)
    {
        if (_parentUnit is null)
        {
            _parentUnit = unit;
        }
    }

    public void OnMoveCompleted(Tile newTile)
    {
        _parentUnit.CurrentTile = newTile;
    }

    public bool IsInAttackRange(Tile targetTile)
    {
        return CalculateDistance(_parentUnit.CurrentTile, targetTile) <= _parentUnit.GetAttackRange();
    }

    private void AssignClosestTarget(List<IAutomaton> validTargets)
    {
        validTargets.Sort((a,b) => SortByDistance(a, b));
        var closestEnemyTile = validTargets.FirstOrDefault().CurrentTile;
        if (IsInAttackRange(closestEnemyTile))
        {
            _target = validTargets.First();
        }
    }

    private float CalculateDistance(Tile t1, Tile t2)
    {
        return Mathf.Abs(t1.Coordinate.X - t2.Coordinate.X) + Mathf.Abs(t1.Coordinate.Y - t2.Coordinate.Y);
    }

    private int SortByDistance(IAutomaton a1, IAutomaton a2)
    {
        var tile1 = a1.CurrentTile;
        var tile2 = a2.CurrentTile;

        var distance1 = CalculateDistance(_parentUnit.CurrentTile, tile1);
        var distance2 = CalculateDistance(_parentUnit.CurrentTile, tile2);
        return Mathf.Sign(distance1 - distance2);
    }
}