From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 14/14] uaccess: drop set_fs leftovers
Date: Tue, 15 Feb 2022 08:46:05 +0100
Message-ID: <215c0ddc-54b1-bcb1-c5aa-bd17c6b100a8@gmx.de>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-15-arnd@kernel.org>
 <YgsYD2nW9GjWJtn5@zeniv-ca.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KT/P8js0aZ9RRfJtn9+Iy8SU/ACwWUUkRC7mfdmnyd8=; b=H5JeEQ7zdk5Gdo
	NccsmfGPcBPkI5Tk9fRVsrkmiqlVghf3RqQ3q3vxfx5fIWL4Oe/91ogFlNhu4v1DyNt7meIzkMjAY
	4U0V9sRwPTIq9MrODGFJ7PK7MInTDHFZ4rXT8CRTqEPktAKg6e6oZnJ9Uj8jyKo6/7ucFr3K82/Ye
	Ni/LpH75zA4wu62hsRKIGocv0pm4AOeDBTly7cpyvB7VhGe3yunCJnVY3M89LESBtdBNXMOIW6VDV
	QIAq+Z/hdhn0xycuKfW09ZNrMAHhCZZYeGAUuIGCKvA9jdalyJ7S32LmD00SoyK5cBMFJ1DGBgfWA
	LQZeKDvkpfoGfsXTO8MQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1644911179;
 bh=Gg0eXtIflg4YSdhde6TPBD88ytt9vELXByFDX1EvH5o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cL8nOU4P5zROD6QnSaMf+IFH1JNakyChC41kZoyLmoh4OfhoEdCE5EpqWukFvfrr7
 bbAty2PKJpf0Ivg7eDWbBX9KS9Ervz4FISwmJMXSrYDExxKjWqh9fx5gCxmn7+bcB3
 7iZgNWIrcC7CBfK5HN/OAh9s+XgKDV5Ya7JTmsv0=
Content-Language: en-US
In-Reply-To: <YgsYD2nW9GjWJtn5@zeniv-ca.linux.org.uk>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux

On 2/15/22 04:03, Al Viro wrote:
> On Mon, Feb 14, 2022 at 05:34:52PM +0100, Arnd Bergmann wrote:
>> diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
>> index b5835325d44b..2f4a1b1ef387 100644
>> --- a/arch/parisc/include/asm/futex.h
>> +++ b/arch/parisc/include/asm/futex.h
>> @@ -99,7 +99,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>>  	/* futex.c wants to do a cmpxchg_inatomic on kernel NULL, which is
>>  	 * our gateway page, and causes no end of trouble...
>>  	 */
>> -	if (uaccess_kernel() && !uaddr)
>> +	if (!uaddr)
>>  		return -EFAULT;
>
> 	Huh?  uaccess_kernel() is removed since it becomes always false now,
> so this looks odd.
>
> 	AFAICS, the comment above that check refers to futex_detect_cmpxchg()
> -> cmpxchg_futex_value_locked() -> futex_atomic_cmpxchg_inatomic() call chain.
> Which had been gone since commit 3297481d688a (futex: Remove futex_cmpxchg
> detection).  The comment *and* the check should've been killed off back
> then.
> 	Let's make sure to get both now...

Right. Arnd, can you drop this if() and the comment above it?

Thanks,
Helge
