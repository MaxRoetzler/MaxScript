macroScript MaxLock category:"Max Core" buttonText:"Lock" toolTip:"Lock"
(
	if (Core.Node.GetObjectType () == #Selection) do
	(
		local flag = #None;
		local total = 0.0;

		for node in selection do
		(
			total += (GetTransformLockFlags node).NumberSet;
		)

		if ((total / selection.Count) < 5) do flag = #All;

		for node in selection do
		(
			SetTransformLockFlags node flag;
		)
	)
)