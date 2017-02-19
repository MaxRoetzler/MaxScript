macroScript MaxViewProject category:"Max Core" buttonText:"View Project" toolTip:"View Project"
(
	local type = viewport.GetType ();

	with Redraw off
	(
		with Undo off
		(
			if (SuperClassOf $ == Camera and type != #View_Camera) then
			(
				max vpt camera;
			)
			else if (type != #View_Persp_User) then
			(
				max vpt persp user;
				ActionMan.ExecuteAction 0 "40228";	-- Save persp. view
			)
			else
			(
				ActionMan.ExecuteAction 0 "40227";	-- Restore persp. view
				Viewport.SetTm (Inverse (Core.Util.AlignMatrixToView ()));

				max vpt iso user;
				max zoomext sel;
			)
		)
	)

	--Core.RaiseEvent #OnViewportChanged;
	RedrawViews ();
)