Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7632566;
	Wed, 13 Nov 2024 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471201; cv=none; b=EBd/B9z7K35sKxsNEzlHGCiA573cV6J9WBsB+mgk8FgEbq18glcRLmxsR4WSI81qFDGBNBhzzqQHodI/r+KbpAU/QKAALzgoNPt62N2zgSQWUB6D0fVKoigzydJESEIgF2QueUdEeYx1+oOcINWIHC8J8CCiuYuDzq2BQ/E1jlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471201; c=relaxed/simple;
	bh=VY0ZrqBxjZyPiDY9TQ5un5PLJISQejsHZY0VY84GiUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxQ680HD3xW88HU4II/Skg9+kx0voxvOfJxvynZe5G5slPsI2ud4t0zu1sYYk15PlS5282Lhik7vgLnpsu9FJ+Ww0gNFaSSESO/E3nfyUzc6E/vlcRKpkHujp9iCSysKUSVDmiVNov1b8zTFxZSlwHDVIkltsY2lv3ogjxDyiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4BQ9x5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4BQ9x5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6A3C4CECF;
	Wed, 13 Nov 2024 04:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731471201;
	bh=VY0ZrqBxjZyPiDY9TQ5un5PLJISQejsHZY0VY84GiUI=;
	h=Date:From:To:Cc:Subject:From;
	b=F4BQ9x5h8plo+SwgP2zGLqxRPMZVwQ5xtw1a7Bs7y09mkDQB5MU53wOS9srmd7rwL
	 6NNHpimJWUdlAR2khRq03NLcxOdmXSiLX0R2Pu3E/XIioq+APqNZeHUMk2L/CRDWQb
	 D7uZt/oMsLGWpJGicaDFpA7NPLbKDCz2PYnYDL2nz2nXzcdbQf3srvYMMId5dSR97R
	 ffFMQfXRXZ+Bh37wqrzFNx58enVZPpgbrqR8YfRc1hYqWKdwO5xJe0yo8hAtFDY0PO
	 qt7awwp7IE0mgUOlLe/ntYFn1WwRuVQu+CAy8J7vBDX7yd7/SxW7oGg6SXcG7Xs9i6
	 n+ZRf2ZIaBmgg==
Date: Tue, 12 Nov 2024 21:13:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org, llvm@lists.linux.dev
Subject: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL out
 of range)
Message-ID: <20241113041319.GA158543@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

With next-20241112 (and some prior versions) and tip of tree LLVM, I am
seeing a link failure, possibly because the kernel image has gotten too
large? A simple reproducer (KCONFIG_ALLCONFIG is needed to workaround
other tangential warnings/issues):

  $ make -skj"$(nproc)" \
         ARCH=hexagon \
         KCONFIG_ALLCONFIG=<(printf 'CONFIG_%s=n\n' {DRM_,WERROR} GPIB_NI_PCI_ISA) \
         LLVM=1 \
         mrproper allmodconfig vmlinux
  ...
  ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160): relocation R_HEX_B22_PCREL out of range: 2098032 is not in [-2097152, 2097151]; references 'memset'
  >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)

I did notice that this error was not reproducible with LLVM 19 so I did
a bisect of LLVM and it seems like commit 6b11573b8c5e ("Recommit
"[FunctionAttrs] deduce attr `cold` on functions if all CG paths call a
`cold` function"") in main introduces this, so maybe it is that
.text.unlikely grows enough to make .init.text be too far away from
memset() in .text?

As an aside, do you folks working on Hexagon do any sort of validation
of the kernel and toolchain? I feel like I have run into a decent number
of Hexagon-specific issues this year and I am curious if any of these
things have been caught by any testing that you might be doing.

Cheers,
Nathan
