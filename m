Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117916;
	b=5gPtxOxkthKFs0hzP4OvehYIRh6obhT5pflQj85J5DUiZhjeukVml2Cl4kLdFwHdhB/M
	 t4o1SLAEWry6oaFxrh6NVwIHRVOJDi6kM4dJ6JMNW9yAh7+/9R9Qb88m6359feIASjTqy
	 yH+E/+MLhzFHzFzuQSXcxvGfaAvO3f78Qr9PWaJ2uZL7Jlc2W1sP9jasBMudj9brjatUi
	 lwjidUEXXcPb7L6jBVyJKinPBoLGr2Ks2KimMQ1f9zEPqGY1bvlH+Nq8TJpPxAaLibXtm
	 7oQPzkRLlXzj9vkAfrA8JfH0reFXcafDNiJroTHwRsJA3ajjQ7hrjlaAHi9IY8B4eZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117916;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nchU52RTjWs7KjsoiHeauziNB+V+tmCBpSxonOanMwo=;
	b=DWjASBp6DkdtXj5mLQFMZPHsaghY3yKD9QV07XRcDVYv+uFvkYdGAxveHyVGBztzKTL6
	 AJBhn9natysVp+UwhAquGxB+YtfKdMMRuvNLDpvJ2wn0J+lHCGg89ydx6Qf198557R9tg
	 87o3DZpKZWXd2EvWQpNZS1ePWQMsnlMbKwC9I3eAvULq2F+ZeXgHjjsXzSuy1fDJXzC+/
	 kshDHscQ/Q1/bYjH/87IC4aPqHK0rN7gKk9kmw4FYtDdsTzRFlp+TMoffKRfejsgV4nzS
	 dKTwyOFKG51OyVkaMFWMKolUBaEFsruGUpDARK7Qa6rTWBv+mBVOXnDZeKbz/5AGodw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VrkBE/oi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89460606A32C;
	Thu, 19 Nov 2026 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrkBE/oi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E727C1F000C5;
	Thu, 19 Nov 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117916;
	bh=nchU52RTjWs7KjsoiHeauziNB+V+tmCBpSxonOanMwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VrkBE/oiPQZufNJ2RhZ3kJxk4PL0U6ueSEZ0XGbeGMV+H/ViBgrfXJhsXxtiJkn09
	 6vmMT7yQfCWplX+tFVw/Sxa3TAyTDjqwyjBMbr6wD6Lyvnyf+IYnhGrbP/RJCV4NA9
	 tG15RHUnMqEUp6/k6Q6S6ttDqaRcp7gY0k00RxIN0pqqjX2oPVxiqRUci5C4AYaZpE
	 VjkCnhwU6k3DZb3LT81OphXdvCWt3ptXaRK8NSfMx3qYGyQSZjl9tK//6wWx+TK4Ed
	 5/UMPtgX8eakfk1mun79N0b5EHV1VVxCXxVgaMaAx/Gk2iIwVW5bvrBKbmuqZENiSV
	 dHFmwGVdnRYzg==
Date: Thu, 19 Nov 2026 12:51:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Brian Cain <bcain@kernel.org>, linux-hexagon@vger.kernel.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: hexagon: allmodconfig does not link with LLVM 17 and 18
Message-ID: <20261119195152.GD875856@ax162>
References: <20261119054908.2988120-1-shingekinocore@gmail.com>
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119054908.2988120-1-shingekinocore@gmail.com>

On Thu, Nov 19, 2026 at 01:49:08PM +0800, Tzu-Ching Yang wrote:
> Nathan, once the fix is merged, the ClangBuiltLinux CI could build
> hexagon allmodconfig with LLVM 17 and 18 again (disabled in
> continuous-integration2 d9d773a8859c).

Thanks for the heads up. I probably won't re-enable them right away
since we are a little build resource limited right now.

-- 
Cheers,
Nathan
