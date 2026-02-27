Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D13D3484;
	Fri, 27 Feb 2026 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186715; cv=none; b=cqUlwTtO1sOqFOB1bxq65WDh9WLgBZAV51dkAE6KpLMxZNjXMZr6ADpom0cs+eIcFNqxd0nc8giixsSbEFEMCiWahv7XDeMDJen5/OXauwmBpHLvmkHuMB/fd8CG3k2nmUv1E4zd63enB6+UFSOADRmxUQQfpo6/8Kwc9q7Y2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186715; c=relaxed/simple;
	bh=/h6f3QLOxuuid5asbbOFfZv+8WDAyabeBYdLHHiq0Xw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QBkR01VKmLUkJdaxvC3osFPeN5G0BUxP48CJ0Q1sAwDjZheqstcSS5qWZq84QRb7lOlXCGUOGDzs2fiO0wHTx6d7AeMdwORt74TAaE5uEhQsOwZ5c0PVuyVEq8M9q+HoJoWMkdPtsB5oHrpu3qkODFigMXDw7FGcSIzHrBtsUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X9YMktjM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qztr751D; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X9YMktjM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qztr751D"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 58DBF1D00218;
	Fri, 27 Feb 2026 05:05:12 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 05:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772186712;
	 x=1772273112; bh=vjw83tNluzxe2bS2DjlouflJ0ANfZ6e/JJwzVbAr7tQ=; b=
	X9YMktjMloK2zOhGHj0q+5Tt5rZj71nr0/oYqubhSyHXVsxIuPw0wS87eKl42Jd0
	0w3d8rJMeUe1/1KEbv90F+C/4NRPNF34VbVj7y6kI9/gIaqVQhWKj38hpaEEgXk/
	jgsIMcQavXsM1QanAcgoioapBdGb19tTaacsUyV2o5CfuF/7sditmj+T2DOFl1/k
	54t0/2eEsI4GqCmHrXFpB3FsnWr/7taMReozNczjcWUp6WQ3XdL94skPqCFacLrs
	bEuzFAyP8w4MzYHO1SsSXFCy0mZxN9TnI6hDcfBUcmfa3DoAg24LeA5vA3Ec7pg2
	hIgQbU4mSxAm7GN9cXD2RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772186712; x=
	1772273112; bh=vjw83tNluzxe2bS2DjlouflJ0ANfZ6e/JJwzVbAr7tQ=; b=q
	ztr751D8lprr8SNeCPzZsMSMwOhmAj5yMpHyX1DGJbLYe71gVSkattC5A0Hhe+zF
	sQp1FR0KFjJCe8mJTlFfuDJEhP+xTxKP+TjD9d6blhA+xwlXi+kyNLknGdVT69fe
	CIRsF+fR+AzaUS1o+L5COGr3BtzOqzykaSERL/gfs+IMwQWB781S1kM1Ai7xXxhO
	nssHlJ9LTE74YLFsH/pjQYK4qv8DUW922qUh+BfAaLCHL/n+bun11C9twTiiAEBw
	YEc5+ogZjd67baZhv688mA4k9tOZR3oLVDfXNL4qjVntbaoT1X7bCspj4mhDWwiE
	4ugCcks1vThYduoPqHnTQ==
X-ME-Sender: <xms:WGyhae03c8JrpQqtc61tCUXPYJFWttQGNFwzijzDrlCjkjbijL7DDQ>
    <xme:WGyhab6RWD_Eg_KV_c2bwWmiVrjkjcjkIwmnHeRBk5psEk_iQSqh5gkW5f6d311C8
    JXu2JsBuaw-y8K_XJDNWo1B6WQHhqyfr84Gt1XD0J_-SUN_6QOVQeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsggtrghinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrth
    hhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnshgtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonh
    higidruggvpdhrtghpthhtoheplhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhksghuihhlugesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigseifvghishhsshgthhhuhhdrnh
    gvth
X-ME-Proxy: <xmx:WGyhafmo0s3A6bwA-LOOK3OwVDVw_AYY-hBSLlyV7VZr6Rypg0A1OQ>
    <xmx:WGyhaVaIwcx3e_evytfKGfZPz0wPKuyRWeKQwIxvjNTokJJejqfmgA>
    <xmx:WGyhaZQlStkucEiWfa851lSwkc9WR0BYbMk_JU6PbDFO2dIr7XiQwA>
    <xmx:WGyhaXutUSxaw1jq6CE0eO9QnYm85yNZZK3UHoSg3IBlf2HG3fcTxw>
    <xmx:WGyhaQpDN0SzKbvdVkhyC2pIMc6gEkrntJZEOuRQI4_6J4OU3Rk0UyaE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02A42700069; Fri, 27 Feb 2026 05:05:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxRtHzFcvrMk
Date: Fri, 27 Feb 2026 11:04:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 "Brian Cain" <bcain@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org
Message-Id: <eddd2b82-6ad2-4345-82fd-21606fa7d245@app.fastmail.com>
In-Reply-To: 
 <20260227103449-a526a376-153c-4f86-bfc9-2eddbdde58fd@linutronix.de>
References: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
 <67674db4-4da2-484c-be59-c97144083179@app.fastmail.com>
 <20260227103449-a526a376-153c-4f86-bfc9-2eddbdde58fd@linutronix.de>
Subject: Re: [PATCH 0/9] kbuild: uapi: remove usage of toolchain headers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026, at 10:38, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Feb 27, 2026 at 10:18:41AM +0100, Arnd Bergmann wrote:
>> On Fri, Feb 27, 2026, at 07:37, Thomas Wei=C3=9Fschuh wrote:
>>=20
>> I had toyed around with a similar series, using a slightly different
>> approach of always using the in-kernel nolibc headers, and making
>> those compile across all architectures (using empty stubs for those
>> that are missing syscall entry functions).
>>=20
>> I don't care much which way we do this as long as we can build test
>> the headers, but I wonder what your reason was for picking this
>> approach over the other.
>
> My goal is to reduce the reliance of the UAPI headers on libc ones.
> Hopefully we can remove libc usages from the UAPI headers and then also
> drop the compatibility bits from the stub headers. If we use the full =
nolibc
> the message to UAPI authors would not be clear and new dependencies ma=
y be
> introduced again.

Good point, thanks for the clarification!

      Arnd
