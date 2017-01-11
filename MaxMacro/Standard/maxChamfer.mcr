macroScript MaxChamfer category:"Max Core" buttonText:"Chamfer" toolTip:"Chamfer"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			case subObjectLevel of
			(
				1 : $.Edit_Poly.PopupDialog #ChamferVertex;
				2 : $.Edit_Poly.PopupDialog #ChamferEdge;
				3 : $.Edit_Poly.PopupDialog #ChamferEdge;
			)
		)

		#EditablePoly: 
		(
			$.PopupDialog #Chamfer;
		)

		#EditableLine: 
		(
			SplineOps.StartChamfer $;
		)
	)
)