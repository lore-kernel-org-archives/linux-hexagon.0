From: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v2 05/13] Move EM_HEXAGON to uapi/linux/elf-em.h
Date: Wed, 20 Mar 2019 21:19:26 -0400
Message-ID: <CAHC9VhT3TXnZoARX=powgCjxdruV_H58sM3Gmc8BjOHnvXpffA@mail.gmail.com>
References: <20190317232908.GF16301@altlinux.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzDD0zY7ocErcFqZPMrXjysu/75kHNdRiWI1f+hCUAc=;
        b=KSdCZILNJh/i1FMeuYyqWj3x2h6ZRcGSVEy+EwyEFcOynT3qV4dOOGtxz3QwQRRHbD
         Ty5z/7KDLWzSwHRrnLngUkgIvvoLKo3dwCa06qWh2TH2zGY/i5OLqsWcLHg4IZgs8icZ
         BFIyfFTIpjPngDd2bakDyBkvpgG1Z0k+WwftltRTNcs4oaboXtwAC2tzxBUItBe5Nam1
         At87vznjXcTjWvH/ZLaZi6c6eGBrHcHkHDr9oVPC3bX8cc3MVkFSkQ098UGb6OhxztIG
         4Myk7htUSUdZ6FvQfJeKXn7uCVROlqhAwibRCu4nl9IJhkdb7wLJa7zYwPeR0idoTbp1
         GBbQ==
In-Reply-To: <20190317232908.GF16301@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-audit@redhat.com, linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:29 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This should never have been defined in the arch tree to begin with,
> and now uapi/linux/audit.h header is going to use EM_HEXAGON
> in order to define AUDIT_ARCH_HEXAGON which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/hexagon/include/asm/elf.h | 6 +-----
>  include/uapi/linux/elf-em.h    | 1 +
>  2 files changed, 2 insertions(+), 5 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
