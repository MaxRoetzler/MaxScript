macroScript MaxMaterial1 category:"Max Core" buttonText:"Material ID-1" toolTip:"Material ID-1"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 0;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 1;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[1] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[1]; 
						false : node.Material = MeditMaterials[1];
					)
				)
			)
		)
	)
)