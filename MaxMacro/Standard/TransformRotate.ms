(
	local TransformRotate = function TransformRotate =
	(
		case (Core.Node.GetObjectType ()) of
		(
			Default 	: max Rotate;
			#UnwrapUVW	: $.Unwrap_UVW.Rotate ();
		)
	)

	Macro.TransformRotate = TransformRotate;
)