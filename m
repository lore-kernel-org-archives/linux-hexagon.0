Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4811632F9;
	Wed, 13 Nov 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522325; cv=none; b=E4olFqkSbsLU1crKEtsw9Nxtb+UWUlvPIZViWyWSCNnei76NOl20+96pyP9JZZvXaFpeVhFC+DRPDA4r2Bn2DT2k6Xhl7+O3uv8TMBwLX3aPo4bemMPl02tOQbZsHo1p6HlarKP6CiEQZQE/YuFZF1V153XaSV+SybXpTqv5DE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522325; c=relaxed/simple;
	bh=6zUKZho2kGFNKKkfJygzfNW0C43ij3YPJ9Tg6OFTxts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJfoyFCTBIgfvLnJxAt8G5l9+jF3MonCQcwjNpomrf/DRNfvRZoAfZSeP7E6Gnw/m3P/HOUawZE7M84v85UJQpGDh506SNV7I5j+E61csphiJfR6Fq5Kc3W47ZT5QQqbk+LdUrhgSUIQadMulxUdRDTcF5WrOMwrv/2aEYhqCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr+zO/n/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr+zO/n/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E73FC4CEC3;
	Wed, 13 Nov 2024 18:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731522325;
	bh=6zUKZho2kGFNKKkfJygzfNW0C43ij3YPJ9Tg6OFTxts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mr+zO/n/IohgfM7sh04+c1q6bQKSMVOQ/lT8b4BQm1tGHYEQZ1WHaBBoCM42Siz//
	 VbdHPhzvmC8KJTxsPXTHUxTQZS82JTuMUVfFBZ5Ij9AWQO1x4XZNfpMdsQh6XyheiK
	 RaSk8z+ro/HCg445sio/1kQffTQLRyzwG5yNEfvJ2BzT8tZFxjrzik+CNnaOn01nuj
	 Xb1rRvSZiBd8I0p0JyN5rRWWx9w18qNQY0W3x5XAZD6MB+Fxjz0PRYkpTwdbeWaya8
	 hX95C1Dz32r8wrV8F50LO8eBsYX1aeX0yOFMYMfWGqndqAQMJX2psRMCUBvAfORXBW
	 MSK2IrQbuG1iQ==
Date: Wed, 13 Nov 2024 11:25:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Cain <bcain@quicinc.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Alexey Karyakin <akaryaki@quicinc.com>,
	Sid Manning <sidneym@quicinc.com>,
	Sundeep Kushwaha <sundeepk@quicinc.com>,
	Shankar Kalpathi Easwaran <seaswara@quicinc.com>
Subject: Re: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL
 out of range)
Message-ID: <20241113182523.GA2701299@thelio-3990X>
References: <20241113041319.GA158543@thelio-3990X>
 <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>

On Wed, Nov 13, 2024 at 02:18:03PM +0000, Brian Cain wrote:
> >   ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160):
> > relocation R_HEX_B22_PCREL out of range: 2098032 is not in [-2097152,
> > 2097151]; references 'memset'
> >   >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)
> 
> This error seems to be due to an incorrect range calculation for this
> and other relocations.  Alexey has a PR for lld under review
> https://github.com/llvm/llvm-project/pull/115925

Thanks! This does appear to resolve this particular problem for me. Will
that need to be backported?

> In addition, since our initial hexagon port landed, lld has added
> support for range thunks.  And Alexey and I have a PR for that too
> https://github.com/llvm/llvm-project/pull/111217 - this should make us
> generally more robust in the case of larger executable images.

Good to hear!

> > As an aside, do you folks working on Hexagon do any sort of validation
> > of the kernel and toolchain? I feel like I have run into a decent number
> > of Hexagon-specific issues this year and I am curious if any of these
> > things have been caught by any testing that you might be doing.
> 
> We don't do enough testing of the toolchain changes with regard to the
> kernel.  I think we have room to improve there.  I'd like to
> incorporate more testing into our workflow for landing changes in
> upstream LLVM.

I see you made some comments on this downstream but if you want any
input or help, I am happy to provide it.

Cheers,
Nathan
