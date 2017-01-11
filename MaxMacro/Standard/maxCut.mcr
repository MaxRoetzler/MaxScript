macroScript MaxCut category:"Max Core" buttonText:"Cut" toolTip:"Cut"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			case (subObjectLevel == 4 and $.SelectedFaces.Count > 0) of
			(
				true  : $.Edit_Poly.ToggleCommandMode #Quickslice;
				false : $.Edit_Poly.ToggleCommandMode #Cut;
			)
		)

		#EditablePoly: 
		(
			case (subObjectLevel == 4 and $.SelectedFaces.Count > 0) of
			(
				true  : $.ToggleCommandMode #Quickslice;
				false : $.ToggleCommandMode #CutFace;
			)
		)

		#EditableLine: 
		(
			SplineOps.StartRefine $;
		)
	)
)