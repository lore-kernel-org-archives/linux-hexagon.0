From: Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
Date: Wed, 1 Mar 2023 07:41:30 -0800
Message-ID: <20230301154130.GB3505369@debug.ba.rivosinc.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677685296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T04RMfKzSUFRrZ3CYc3+bErGU8vpxkP2QVI3mwlpG78=;
        b=RacUjtkKVhkSdFUBywOGho+8dt8NsK+GHdxWXdQ69WX2yCf/yYWl7r6icMXBWT/ShM
         KzbzJEeKqlnWntlEh4Hu5sno9Ak81pDzhFum2pY94j4Sv2hldxTUvXOesOtDXjR8r6gc
         qTgIZDS9fRsSDLNbTTTqAFsgPsTJ/DQ+0jjGE9ek1g+5UBhUcmjFAxCNoVki1FxJorhz
         1mqoDsTuoBLwUNz+cTKmWUvmBN0WlvjuL/8NCCPe/UsZ69pgJ+6lNteW1mdicJGes/KY
         sz2TvcyHAjAaMaJRH5/VJiCFama3PVa+Xs98E38Ow6CsZfQ4ni3p2/e/LUrMvV5jGCLw
         yEmQ==
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-14-rick.p.edgecombe@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>

On Sat, Feb 18, 2023 at 01:14:05PM -0800, Rick Edgecombe wrote:
>The x86 Control-flow Enforcement Technology (CET) feature includes a new
>type of memory called shadow stack. This shadow stack memory has some
>unusual properties, which requires some core mm changes to function
>properly.
>
>One of these unusual properties is that shadow stack memory is writable,
>but only in limited ways. These limits are applied via a specific PTE
>bit combination. Nevertheless, the memory is writable, and core mm code
>will need to apply the writable permissions in the typical paths that
>call pte_mkwrite().
>
>In addition to VM_WRITE, the shadow stack VMA's will have a flag denoting
>that they are special shadow stack flavor of writable memory. So make
>pte_mkwrite() take a VMA, so that the x86 implementation of it can know to
>create regular writable memory or shadow stack memory.
>
>Apply the same changes for pmd_mkwrite() and huge_pte_mkwrite().
>
>No functional change.
>
>Cc: linux-doc@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-alpha@vger.kernel.org
>Cc: linux-snps-arc@lists.infradead.org
>Cc: linux-arm-kernel@lists.infradead.org
>Cc: linux-csky@vger.kernel.org
>Cc: linux-hexagon@vger.kernel.org
>Cc: linux-ia64@vger.kernel.org
>Cc: loongarch@lists.linux.dev
>Cc: linux-m68k@lists.linux-m68k.org
>Cc: Michal Simek <monstr@monstr.eu>
>Cc: Dinh Nguyen <dinguyen@kernel.org>
>Cc: linux-mips@vger.kernel.org
>Cc: openrisc@lists.librecores.org
>Cc: linux-parisc@vger.kernel.org
>Cc: linuxppc-dev@lists.ozlabs.org
>Cc: linux-riscv@lists.infradead.org
>Cc: linux-s390@vger.kernel.org
>Cc: linux-sh@vger.kernel.org
>Cc: sparclinux@vger.kernel.org
>Cc: linux-um@lists.infradead.org
>Cc: xen-devel@lists.xenproject.org
>Cc: linux-arch@vger.kernel.org
>Cc: linux-mm@kvack.org
>Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>

Acked-by: Deepak Gupta <debug@rivosinc.com>
