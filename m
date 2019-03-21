From: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v2 06/13] hexagon: define syscall_get_arch()
Date: Wed, 20 Mar 2019 21:19:49 -0400
Message-ID: <CAHC9VhStCeH=fmgt8TAG+MeW_OWsLC75LrZeh2pUcmnWSWCBgQ@mail.gmail.com>
References: <20190317232932.GG16301@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvBwdTcEw1R5zX8xVZtB1Te0FHgHwkHqhIHaa6yTtKo=;
        b=oR0ZYNiHYYSmZwTkUCioNpDX6I8AjLk+QXdNl1Ozv82+/8REq7h9nf9vgkf1E2v5aP
         SA76FY5IyxajClhEF99T1EFnyP7LMwBC3vhJfM9xgZ+eBKk52bSEwsmWpcnIwEnshld2
         pVJ1IemWN8HMXOgwJRLoZJQ1fo+gyLZQJJcr2S7eYmPNqe/3AVEEVExlpUDbghpDODIS
         x+6P/vQ18k9Q12xjLKv+GRZFaVZBwD27ItU/yVBBlMYGoNGvCNil5+ez3vZbWjgqDbpa
         14x3bwPLR2ACGOgr9MvV2aMlTurIkVsP+PgQH3eQXqQbhljmtN/Ey2I71pPNQEcqO07r
         XqzQ==
In-Reply-To: <20190317232932.GG16301@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>, linux-hexagon@vger.kernel.org, linux-audit@redhat.com, linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:29 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/hexagon/include/asm/syscall.h | 8 ++++++++
>  include/uapi/linux/audit.h         | 1 +
>  2 files changed, 9 insertions(+)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
