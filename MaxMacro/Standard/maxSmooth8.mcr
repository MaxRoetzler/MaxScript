macroScript MaxSmooth8 category:"Max Core" buttonText:"Smooth ID-8" toolTip:"Smooth ID-8"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly:
		(
			$.Edit_Poly.SetOperation #SetSmooth;
			$.Edit_Poly.SmoothingGroupsToSet = (2 ^ 7);
		)

		#EditablePoly:
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceSmoothGroup $ faces (2 ^ 7);
		)
	)
)