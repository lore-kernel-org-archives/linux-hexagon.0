Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A86262A3;
	Thu, 14 Nov 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604716; cv=none; b=jHUo+2ADbO8DID+23WXE1/iEiC3lD8tvQWjs94ZL0g0+5iZ7MMGmpDOpVV8jF0LClXuBAiIlbvE5CMFhaJ46GpRvVD7zgJl1P5rPxHRQMP8ZkqwHFRv+zoP9NgeZQZwny9AdYif8uC9ZSJQI+hrMLKCM53rWpmZJni6FPlh5Cu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604716; c=relaxed/simple;
	bh=tBxxWmfOqYr/kDobeGFGIMoT6xPlx0njLqyX8nov6mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU/yZvax5dZ1i/JQjD3dfTXb+Hsn0aR6+VWydAmwS/C2h0EzNZsqW6WD5+tzL8KQ7ZoAYvKthB6GY1mE5rU9aL4miT2vT/e8Tssz1lLTMdxDPn99jWVeZMr+/rrU03siRXD2ZZnvB8N6ny6eLqpFhK4koSzeDMtTy/v6B2y1XAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJpOeS3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJpOeS3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DEDC4CECD;
	Thu, 14 Nov 2024 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731604716;
	bh=tBxxWmfOqYr/kDobeGFGIMoT6xPlx0njLqyX8nov6mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJpOeS3VW1PLkb92B/Q9r/tPvobq7ErytAqjFC4lr0Z2i5uVXWsyKYKtZZObKuR5C
	 8GqaimQeoxK3tGKvxJ/sJyRDTuvv2UpMKKHqmbUgPILhS0fpmAvs/V+5HTgO3oiJ3p
	 HK13s/zUj28FJxhgZselNl43FQyjEXTe3qIkqYNdBDeWbEKhtrN3DvxOiOjQ2u1EzK
	 hdTL+b7PwqoRdqU3M++qTFHP/4tm0nMT9vpOFCYM8ZDiG2HFBGnHj0e2OaUKJHQOjA
	 H9Ksl3elfJIpgsFaD/IuvOc67zksVYW1JY4Ei1pnJh5fcT6lNwL/J7E04ySSKsp6yK
	 ZxHGWOkNNRbgw==
Date: Thu, 14 Nov 2024 10:18:34 -0700
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
Message-ID: <20241114171834.GA1956005@thelio-3990X>
References: <20241113041319.GA158543@thelio-3990X>
 <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
 <20241113182523.GA2701299@thelio-3990X>
 <DS0PR02MB102504C35F7F82A71261B9381B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR02MB102504C35F7F82A71261B9381B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>

On Wed, Nov 13, 2024 at 06:34:15PM +0000, Brian Cain wrote:
> > > This error seems to be due to an incorrect range calculation for this
> > > and other relocations.  Alexey has a PR for lld under review
> > > https://github.com/llvm/llvm-project/pull/115925
> > 
> > Thanks! This does appear to resolve this particular problem for me. Will
> > that need to be backported?
> 
> I was hoping/planning to request it to be cherry-picked to 19.1.x once

Sounds good!

> it lands on main - are you asking for branches older than that too?

No, I am aware that the older branches are not supported, so we will
just take what we can get :)

> This linker problem has been there "forever" but I suppose the
> compiler only recently made a change that makes it more apparent.

Right, if this becomes more prevalent, then we will just stop building
allmodconfig with older versions of LLVM. For now, I think ensuring the
fix lands in main and gets backported to 19.1.x should be enough to
avoid any issues.

Cheers,
Nathan
