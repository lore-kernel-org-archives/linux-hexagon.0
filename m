From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/4] m68k: use asm-generic/memory_model.h for both MMU
 and !MMU
Date: Fri, 3 Feb 2023 15:31:10 +0100
Message-ID: <862cb71f-0775-916d-b0c9-5247f772d637@redhat.com>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-3-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675434677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBuUxRqwVpT90qSSvu23sLwWbKqZ02KC/SRu5tcTWNA=;
	b=HmrNQHKrlHkEXCpoxDcMZp7g/sMs3K+G4bVM9ILl0aZLjmuYpkeXh0a3CKcYFVFL6wX76/
	S7QYF7/mqagVvRBqwWjCTrfwjOgoIs55l+wS4OQrnxUBNBFjW202VIXVuo80Co0umdeLJR
	f10/Thvc8+iGpjAN/Jx7MbZUeDOJs8E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675434677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBuUxRqwVpT90qSSvu23sLwWbKqZ02KC/SRu5tcTWNA=;
	b=HmrNQHKrlHkEXCpoxDcMZp7g/sMs3K+G4bVM9ILl0aZLjmuYpkeXh0a3CKcYFVFL6wX76/
	S7QYF7/mqagVvRBqwWjCTrfwjOgoIs55l+wS4OQrnxUBNBFjW202VIXVuo80Co0umdeLJR
	f10/Thvc8+iGpjAN/Jx7MbZUeDOJs8E=
In-Reply-To: <20230129124235.209895-3-rppt@kernel.org>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Vineet Gupta <vgupta@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, l inux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, loongarch@lists.linux.dev, Stafford

On 29.01.23 13:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
> 
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

