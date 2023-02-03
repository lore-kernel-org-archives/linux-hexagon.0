From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 3/4] mips: drop definition of pfn_valid() for
 DISCONTIGMEM
Date: Fri, 3 Feb 2023 15:31:32 +0100
Message-ID: <1d13abeb-ea4b-6314-2fd2-1b86b8f4d6c5@redhat.com>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-4-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675434697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/decAsXzWzOr1Fn5getBDCGr7TKXQO+f4q0N0MxWErI=;
	b=A2t109/yTXLOQ7tcfcBaBddd5w1h6mW4obqM9xZpsk3Fd0BvOmYoaCX+eWZTACR2DBxVuy
	h5agvau6d5Em5bsbT2t3iqSNJmfy6uxTGWYdlt9hUiHPzzYUIqHBL6Yg8roAqxoTfpeooF
	1e9s/f9jpVKdbUh5paPBhSIYtL+LbtA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675434697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/decAsXzWzOr1Fn5getBDCGr7TKXQO+f4q0N0MxWErI=;
	b=A2t109/yTXLOQ7tcfcBaBddd5w1h6mW4obqM9xZpsk3Fd0BvOmYoaCX+eWZTACR2DBxVuy
	h5agvau6d5Em5bsbT2t3iqSNJmfy6uxTGWYdlt9hUiHPzzYUIqHBL6Yg8roAqxoTfpeooF
	1e9s/f9jpVKdbUh5paPBhSIYtL+LbtA=
In-Reply-To: <20230129124235.209895-4-rppt@kernel.org>
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
> There is stale definition of pfn_valid() for DISCONTINGMEM memory model
> guarded !FLATMEM && !SPARSEMEM && NUMA ifdefery.
> 
> Remove everything but definition of pfn_valid() for FLATMEM.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

