Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3D16B723;
	Tue, 20 Aug 2024 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135214; cv=none; b=UZmFFL83umJuRQvixUUbyYQj5BpjTdVT//3mRt9XdLV1w7MtzuIPi7BJNEV9BcPTo3KbrZXqC043+yfBkVPausSJuF0ZRB2c9sU4sk1D8nI2uas/mYuikrddxOWLFKutq24U1FL4lar5ku3moNMaOHWZJeCrNwc3OigqIsMyga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135214; c=relaxed/simple;
	bh=0nB4vt5mVf9gQd39iI+jKGpfL7Lv4UpO0haxePtZXEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ah90aMgeVI+WAtqjeMvV/dHjS5B/CnGtYPc1+SSOGN4G/WPbn/UXrAWkX1S5l3W92PTFMOL/0QhzItU8aet4dw2Us0KjgRDaot1pp+jtnGkMvOkT7rR2xwqH6b4AaPpEBxrRyuRndbqhAQvqD/oHE4dIKI1X7/ibrSAk9pXa1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ZDNcrElU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZDNcrElU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724135209;
	bh=EFXLGZEJkQUFQN28krLsjRFbPfS1YdUIsO6keM3oM8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZDNcrElUZ2xY3s8w2eLhoYpi2YViK/FMkN+ADmqFd+TanHYCabHsCvxKxJDrMJmQ3
	 PALcnEi8+N6YuFVo/NT9ULv1COUzAljpcuypZ5EsiRuQHXj0Y4ejCBMJvxI3/YPw22
	 Cx1ZzVd1bkUvMnEHpxzGLiv+yEvYtXyS5Oje/tUckPFLL9zIPpyvzxzVgz2GUBwZ3N
	 6mpBsvhBFEiLa9uIceT/jTftvX4piUfkdT2doVoBbq3BLaEwDAGmCQLSZo7ixVG2WD
	 U/UKzAas2jHBiOPL5qaZxuF4uBCF+93ttNCAf/R7WStVDr/gZVSeIwEjWOctOtHn7y
	 lqUl+TYJ99dZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WnzyD15rhz4wd6;
	Tue, 20 Aug 2024 16:26:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 oliver.sang@intel.com, pedro.falcato@gmail.com,
 linux-um@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon
 <linux-hexagon@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
In-Reply-To: <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
Date: Tue, 20 Aug 2024 16:26:43 +1000
Message-ID: <87y14rso9o.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, 19 Aug 2024 at 13:15, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ok, I did a quick hack-job to remove that disgusting
>> install_special_mapping() legacy case.
>>
>> With this [..]
>
> I forgot to actually attach that "this". Here it is. For real, this time.
>
>                    Linus
>  arch/csky/kernel/vdso.c            | 28 +++++++++++++++++++++-------
>  arch/hexagon/kernel/vdso.c         | 14 ++++++++++----
>  arch/nios2/mm/init.c               | 12 ++++++++----
>  arch/sh/kernel/vsyscall/vsyscall.c | 14 +++++++++++---
>  arch/x86/um/vdso/vma.c             | 12 ++++++++----
>  include/linux/mm.h                 |  4 ----
>  mm/mmap.c                          | 32 +++++---------------------------
>  7 files changed, 63 insertions(+), 53 deletions(-)
>
...
> index 1bd85a6949c4..5e68ab7a8898 100644
> --- a/arch/sh/kernel/vsyscall/vsyscall.c
> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
> @@ -36,6 +36,10 @@ __setup("vdso=", vdso_setup);
>   */
>  extern const char vsyscall_trapa_start, vsyscall_trapa_end;
>  static struct page *syscall_pages[1];
> +static struct vm_special_mapping vdso_mapping = {
> +	.name = "[vdso]",
> +	.pages = syscall_pages;
                              ^
                              should be ,
> +};

cheers
