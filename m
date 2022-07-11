From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V7 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Date: Mon, 11 Jul 2022 13:14:17 -0700
Message-ID: <20220711131417.9cac57d9b88eea8bbd7d8616@linux-foundation.org>
References: <20220711070600.2378316-1-anshuman.khandual@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657570459;
        bh=Qi9KHdTBSLuKZsaLawDZPDz9HT/wF+gH2hGfQ1b/XB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j6XVvkVOWxDOzNjGjTDcj6e6ZY1u9GuvGONiK6EGJe21US8g66C0v4Tv4wCu+5Z3u
         T5lr1fQ/vFxEaXWAl9b5zH6sU86TD4i30OcWtJ4fjtKbOuqrDS6Ez0AqW6I2zqbQ9j
         6Q9WeeDMfajEfQXiH+eWEM5JFOXvwrthQ0YF7SB8=
In-Reply-To: <20220711070600.2378316-1-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, openrisc@lists.librecores.org, linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 12:35:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This series drops __SXXX/__PXXX macros from across platforms in the tree.

I've updated mm-unstable to this version, thanks.  I skipped the added-to-mm
emails to avoid wearing out people's inboxes.

Reissuing a 26-patch series N times is rather noisy.  Please prefer to send incremental
fixes when changes are minor.  It makes it so much easier for reviewers to see what
happened.
