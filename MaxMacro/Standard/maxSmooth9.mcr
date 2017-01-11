macroScript MaxSmooth9 category:"Max Core" buttonText:"Smooth ID-9" toolTip:"Smooth ID-9"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly:
		(
			$.Edit_Poly.SetOperation #SetSmooth;
			$.Edit_Poly.SmoothingGroupsToSet = (2 ^ 8);
		)

		#EditablePoly:
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceSmoothGroup $ faces (2 ^ 8);
		)
	)
)