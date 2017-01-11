macroScript MaxConvertToVert category:"Max Core" buttonText:"Convert To Vert" toolTip:"Convert To Vert"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.ConvertSelection #CurrentLevel #Vertex;
			subObjectLevel = 1;
		)

		#EditablePoly: 
		(
			$.ConvertSelection #CurrentLevel #Vertex;
			subObjectLevel = 1;
		)

		#EditableLine: 
		(
			with Redraw off
			(
				for spline = 1 to (NumSplines $) do
				(
					SetKnotSelection $ spline (Core.Line.GetSelectionAsKnot $ spline);
				)

				subObjectLevel = 1;
			)

			CompleteRedraw ();
		)

		#UnwrapUVW: 
		(
			case ($.UnwrapUvw.GetTvSubObjectMode ()) of
			(
				2 : $.UnwrapUvw.EdgeToVertSelect ();
				3 : $.UnwrapUvw.FaceToVertSelect ();
			)

			$.UnwrapUvw.SetTVSubObjectMode 1;
		)
	)
)