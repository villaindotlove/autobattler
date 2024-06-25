using Godot;

public partial class BaseMovementComponent : Node, IAutoComponent
{
    [Signal]
    delegate void OnMoveCompletedEventHandler(Tile newTile);
    private BasicAutomaton _parentUnit;
    private Tween _motionTween;
    private Tile _currentTargetTile;

    public void SetParentUnit(IAutomaton unit)
    {
        if (_parentUnit is null && unit is BasicAutomaton basicAutomaton)
        {
            _parentUnit = basicAutomaton;
        }
    }

    public void CreateMotionTween(Tile targetTile, float duration)
    {
        if (_motionTween.IsRunning())
        {
            throw new System.Exception("Trying to queue up a new move while the old one is still running.");
        }
        _parentUnit.LookAt(targetTile.GlobalPosition);
        _motionTween = GetTree().CreateTween();
        _motionTween.TweenProperty(_parentUnit, "GlobalPosition", targetTile.GlobalPosition, duration);
        _motionTween.Finished += () => MoveCompleted();
        _currentTargetTile = targetTile;
    }

    private void MoveCompleted()
    {
        EmitSignal(SignalName.OnMoveCompleted, _currentTargetTile);
    }
}