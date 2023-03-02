From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 13/41] mm: Make pte_mkwrite() take a VMA
Date: Thu, 2 Mar 2023 13:19:52 +0100
Message-ID: <ZACUaN0NRNXMwkT2@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-14-rick.p.edgecombe@intel.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677759598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EXqRPO+1UJ/Jugo4uZb8s1y5eA/PT9L+UzCFhY6JB88=;
        b=BDkuvwlB34QQjIUo59EDVmj7oKCVncxfi5b5gZ5JgkhU3aIBDgDeTmJNn7jbJHW3znTvCf
        YFoHuKLNQrQyliq8pTOmjR9MRkIeF/W/wjuynsx9rHark059JR7Yp19Rw8Aocd30uUMCn6
        EDHphDviZmnnExDRi0VvwD18ImB95dQ=
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-14-rick.p.edgecombe@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pa

On Mon, Feb 27, 2023 at 02:29:29PM -0800, Rick Edgecombe wrote:
> [0] https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com/#t

I guess that sub-thread about how you arrived at this "pass a VMA"
decision should be in the Link tag. But that's for the committer, I'd
say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
