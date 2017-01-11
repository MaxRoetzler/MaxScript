macroScript MaxAttach category:"Max Core" buttonText:"Attach" toolTip:"Attach"
(
	case (Core.Node.GetObjectType subLevel:-1) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.EnterPickMode #Attach;	
		)

		#EditablePoly: 
		(
			$.EnterPickMode #Attach;
		)

		#EditableLine: 
		(
			SplineOps.StartAttach $;
		)

		#UnwrapUVW: 
		(
			$.UnwrapUvw.StitchVertsNoParams ();
		)
	)
)