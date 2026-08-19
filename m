Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF23C3F71;
	Wed, 19 Aug 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123574; cv=none; b=m2ZHFVzjvf0Fhzx+GpBioUpq78mKZ5HJmyVzATjYegc8u5QcPfxSjZAGBQ+5+TkQxJjkPta7hgrVEpCz/2CyMesvFCde4zFhl5P/avd/7BQn+DjeDxQfz4HSKi8ZIv7Lh0tVtLF/GVCZrQgjVIbPLtuyrrnN3V/UhrExq6v7dCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123574; c=relaxed/simple;
	bh=s5ETtTp7++f46OFlWHeXyyxW6bm+YJNmRuILtnFlhAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4USLOSS8Yj+UJbvHnr1xMwaQ5ib0GgoVRHVOgojy5ZFHrVjtys1Zv/WPriEUbvYXeRDeofnFGYLtwrKZUsFRXF2M07OIs4bAzzLwQ1aZulO9DX9XNr1HDtxaOscGGFIfNk5WArcN/aK8wuYeoFonRDFWYzQ7iEUpzmFZek5DO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=Omw6CXQ9; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="Omw6CXQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1787123567; bh=uaRHYBn9ya7dcz4c/uVjHHpDQ+Cey//IJ/fn3xaxjxQ=;
	h=From:Message-ID:From;
	b=Omw6CXQ9lyWm56G/LoNOf2TGxHITQUrL6DNq7ZKy0VzD1WuB+5tJ79NjoVrKU9dAI
	 jU+C9Qp0c1sDWdKNhqi2KGCvRU2BW3m9fZpMhCWuRueNg1tBRhIJL+bEYP1/HkvaxO
	 jfOodUh87gXza5ynPqzDnWQcI+ZK10PtPY06GNIU=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 73457C097B;
	Wed, 19 Aug 2026 09:12:47 +0200 (CEST)
Date: Wed, 19 Aug 2026 09:12:47 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Brian Cain <bcain@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add support for hexagon
Message-ID: <aoVXbwcC1qToZTr-@1wt.eu>
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
 <20260819-nolibc-hexagon-v1-3-6bc3be591f09@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819-nolibc-hexagon-v1-3-6bc3be591f09@weissschuh.net>

Hi Thomas,

On Wed, Aug 19, 2026 at 08:31:53AM +0200, Thomas Weiﬂschuh wrote:
> +++ b/tools/include/nolibc/arch-hexagon.h
> @@ -0,0 +1,164 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * hexagon specific definitions for NOLIBC
> + * Copyright (C) 2026 Thomas Weiﬂschuh <linux@weissschuh.net>
> + */
> +
> +#ifndef _NOLIBC_ARCH_HEXAGON_H
> +#define _NOLIBC_ARCH_HEXAGON_H
> +
> +#include <linux/unistd.h>
> +
> +#include "compiler.h"
> +#include "crt.h"
> +
> +/*
> + * Syscalls for OpenRISC:
> + *   - syscall number is passed in r6
> + *   - arguments are in r0, r1, r2, r3, r4, r5
> + *   - the system call is performed by calling trap0(#1)
> + *   - syscall return value is in r0
> + */

I'm not familiar with hexagon, but the file is named hexagon and the
comment speaks about openrisc. Is this a leftover from a copy-paste,
or is there an untold relation between the two, that would then deserve
at least an extra line to explain to those who don't know when passing
by ?

Other than this detail, while I can't judge for the syscall instructions
for this arch, I'm fine with the rest of the patch and the series, so
feel free to add:

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy
