(
	local ConvertToFace = function ConvertToFace =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.ConvertSelection #CurrentLevel #Face;
				subObjectLevel = 4;
			)

			#EditablePoly: 
			(
				$.ConvertSelection #CurrentLevel #Face;
				subObjectLevel = 4;
			)

			#EditableLine: 
			(
				with Redraw off
				(
					case subObjectLevel of
					(
						1 : (SetSplineSelection $ (for i = 1 to (NumSplines $) where (Core.Line.HasKnotSelection $ i) collect i));
						2 : (SetSplineSelection $ (for i = 1 to (NumSplines $) where (Core.Line.HasSegmentSelection $ i) collect i));
					)

					subObjectLevel = 3;
				)

				CompleteRedraw ();
			)

			#UnwrapUVW: 
			(
				case ($.UnwrapUvw.GetTvSubObjectMode ()) of
				(
					1 : $.UnwrapUvw.VertToFaceSelect ();
					2 : $.UnwrapUvw.EdgeToFaceSelect ();
				)

				$.UnwrapUvw.SetTVSubObjectMode 3;
			)
		)
	)

	Macro.ConvertToFace = ConvertToFace;
)