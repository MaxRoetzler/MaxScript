(
	local TransformScale = function TransformScale =
	(
		case (Core.Node.GetObjectType ()) of
		(
			Default 	: max Scale;
			#UnwrapUVW	: $.Unwrap_UVW.Scale ();
		)
	)

	Macro.TransformScale = TransformScale;
)