Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1637E5D0;
	Wed, 19 Aug 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164194; cv=none; b=tXw8iLFJ00XDHBhjx1RysX7PkvWqMVphl3bmEFU5xcgeZkofL98nK80XUAov3oR7SKR1Y9srPVlcA7dPY+gf6oBvCnQxk2feYXMaY5ZIHmvDpoOsD1Z+Brs80u5kj7J2XO3lJ08lHWSYPF6PcuHBdmV+Gb40O8K2PmwAYuw+ZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164194; c=relaxed/simple;
	bh=1gOXIQqehu4vzI0+cQQe1IllJD/Y9iVFumUrisyKrg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzSrcvOWlRq1lu2zqi+LWkqa/YgqfDtURvEz6/Orkx8Ill9imc2CbvQUWNfwokgNeJtbhD7pbZx+oBFIQPzUvARfLmEZ4tLH3dgagPDI5N25urtsPpEPFE14Y5t0vVojjfTmXF/P+TgxFutDHN5k2nLWW8SoCS2oDClkNQnnJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CsV8op3B; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CsV8op3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787164182;
	bh=1gOXIQqehu4vzI0+cQQe1IllJD/Y9iVFumUrisyKrg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsV8op3B7caEeNtNOQTyJQ3IhvPBwpnrWqk3vubyFTgTaX/CPf9a8Vd9ZP7HufmFE
	 7H78DXRd7lBLk/i94uuROQ0bV+rT+U26c/mLC3hW/haaLVvJdhuCUqB7cv3Lrl6p7m
	 /GNdbjm3OOUcJnWPux98XLxu0dpMOiJ5a3/B/dqk=
Date: Wed, 19 Aug 2026 20:29:42 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Brian Cain <bcain@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add support for hexagon
Message-ID: <55da1de0-b034-4b3a-8b25-e4cedfeb4418@t-8ch.de>
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
 <20260819-nolibc-hexagon-v1-3-6bc3be591f09@weissschuh.net>
 <aoVXbwcC1qToZTr-@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoVXbwcC1qToZTr-@1wt.eu>

On 2026-08-19 09:12:47+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, Aug 19, 2026 at 08:31:53AM +0200, Thomas Weißschuh wrote:
> > +++ b/tools/include/nolibc/arch-hexagon.h
> > @@ -0,0 +1,164 @@
> > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > +/*
> > + * hexagon specific definitions for NOLIBC
> > + * Copyright (C) 2026 Thomas Weißschuh <linux@weissschuh.net>
> > + */
> > +
> > +#ifndef _NOLIBC_ARCH_HEXAGON_H
> > +#define _NOLIBC_ARCH_HEXAGON_H
> > +
> > +#include <linux/unistd.h>
> > +
> > +#include "compiler.h"
> > +#include "crt.h"
> > +
> > +/*
> > + * Syscalls for OpenRISC:
> > + *   - syscall number is passed in r6
> > + *   - arguments are in r0, r1, r2, r3, r4, r5
> > + *   - the system call is performed by calling trap0(#1)
> > + *   - syscall return value is in r0
> > + */
> 
> I'm not familiar with hexagon, but the file is named hexagon and the
> comment speaks about openrisc. Is this a leftover from a copy-paste,
> or is there an untold relation between the two, that would then deserve
> at least an extra line to explain to those who don't know when passing
> by ?

It is indeed a copy-paste error.
Thanks for noticing!

> Other than this detail, while I can't judge for the syscall instructions
> for this arch, I'm fine with the rest of the patch and the series, so
> feel free to add:
> 
> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
