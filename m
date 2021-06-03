From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 0/3] hexagon: Fix build error with CONFIG_STACKDEPOT and select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
Date: Thu, 3 Jun 2021 11:59:43 -0500
Message-ID: <09a301d75899$daf244f0$90d6ced0$@codeaurora.org>
References: <20210521011239.1332345-1-nathan@kernel.org> <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739590; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=F429vFtl3XvYQi65CeuZUOOowDumhKntT+Oh2DXf98s=; b=Nrm5pcNws4ECwotZ70hoNmjjBS6OtxBMZJE2yLZgNRBS3jHyrUZNabe47hr1SAAJyFaDsjl5
 StQLaa9dbjtwi/H1iIZn/VGMT6Xs9hZDqOt3DGAMWUAQ1kcFvEhGOwS3QUAq9CC6QvXImMJB
 VlEpebXsyiGW0IQcaiEMpIy9OzU=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nathan Chancellor' <nathan@kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
...
> On 5/20/2021 6:12 PM, Nathan Chancellor wrote:
> > Hi all,
...
> Brian, did you have any comments on this series? ARCH=3Dhexagon =
defconfig
> is currently broken in -next, it would be a real shame if this =
continued
> to regress after you just got Hexagon building in mainline. These
> patches seem like they would be worthy of a 5.13 pull request.

I have started the internal review process to get these queued up in my =
tree.  But I don't know if I would have it in time for 5.13.

> Otherwise, Andrew could pick them up with your ack and stick them in
> front of "mm/slub: use stackdepot to save stack trace in objects" so
> that there is no build regression.

Of course: I'll send my ack for the sake of keeping the build green.

-Brian

