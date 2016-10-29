From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
Date: Sun, 30 Oct 2016 01:05:38 +0300
Message-ID: <20161029220538.GB20037@yury-N73SV>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
 <5823871.3DMLUx5Xtp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-caviumnetworks-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DsY0j3KWVETUuSAOerbFSHXOLU80rc8CaGPxH6kELhc=;
 b=vLHakXOlUA0MP7QJ+/klhh41cNWlCkR/TV0WvU3JbS0Kapv4eiSy2TqtQ6HfbP5H886U5YoUUPKNEL9N2vF/eoFQGUHoPdS4RoDd6GJWN7eRtJLMUKD10bAh/KR4lsMm8b5SsUV5kxhK4ZTnEyGKwW+91yCigGDCceSvwElcwDQ=
Content-Disposition: inline
In-Reply-To: <5823871.3DMLUx5Xtp@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Andrew Pinski <Andrew.Pinski@cavium.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel

On Sat, Oct 29, 2016 at 11:54:08PM +0200, Arnd Bergmann wrote:
> On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
> > The newer prlimit64 syscall provides all the functionality provided by
> > the getrlimit and setrlimit syscalls and adds the pid of target process,
> > so future architectures won't need to include getrlimit and setrlimit.
> > 
> > Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> > list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> > unistd.h prior to including asm-generic/unistd.h, and adjust all
> > architectures using the generic syscall list to define it so that no
> > in-tree architectures are affected.
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can you include this patch in your ilp32 series?

Already did.
https://github.com/norov/linux/commits/ilp32-4.9
