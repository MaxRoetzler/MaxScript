macroScript MaxCreate category:"Max Core" buttonText:"Create" toolTip:"Create"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.ToggleCommandMode #CreateFace;
		)

		#EditablePoly: 
		(
			$.ToggleCommandMode #CreateFace;
		)

		#EditableLine: 
		(
			SplineOps.StartCreateLine $;
		)
	)
)