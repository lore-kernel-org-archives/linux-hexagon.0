From: Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
Date: Sun, 23 Oct 2016 13:57:27 -0700
Message-ID: <4e1a4e68-5c84-ce9d-73df-b7da312cc884@synopsys.com>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ELj5s/+k+d1r6aDJu/QXfIpZkzZOC+e/LhuhFtj791c=;
        b=brAlnI4X+WXtpLTX5Gn83zVb0pJaUghhyedv/d/+VMUPWzBxaghJc6KxRYBgJqYjc0
         X2qDTHnqjCBvX17rwh0uTuzO8Lh9UQAvvRa7ISE/3SVExBSJroUVDjo2eBYho4IMWkVG
         fiGfeDLJT5VFBbFlQgn36jdW4aOU7NpQJB7EANED6F4+/xbpWMFNjH/MXWXuED/I1c0T
         TyL1qAqWQkFLWKlSbsPJia75Q5eKMtgIfzFtuLzGJ+kxWLPH/VAZFv9m8uRgqCDdOukN
         du7J1U6BkUT5T/FE4njcElehX28yl8y4QHGoswVjY5qas/s/o58feC2WwopX1CGu3jG/
         Z72g==
In-Reply-To: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, James Hogan <james.hogan@imgtec.com>, "linux-arch@vger.kernel.or" <linux-arch@vger.kernel.or>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Andrew Pinski <Andrew.Pinski@cavium.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/22/2016 05:14 AM, Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
>
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all
> architectures using the generic syscall list to define it so that no
> in-tree architectures are affected.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com> #arch/arc bits

Thx,
-Vineet
