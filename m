Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D61CDA3E
	for <linux-hexagon@vger.kernel.org>; Wed,  2 Oct 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861699; cv=none; b=VNKjiv5wP6FYU0Iy0mW1ZtFr3s5yCyD2vdHv6tyTcB2oL52cItud3xpipXuQDpycgATEz8wY8pQvGJHxAlqHN3AjEPtH73Qazzf2JPArVocJGAVHjtxI1QN81hmBzNsUa+p5ZbfID0VEQMX5aNKgn8KfIcmRyCeXq1wWYBvuWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861699; c=relaxed/simple;
	bh=Sle3Gs+tG1icXE1sGikrBdFltbCO/Av/Z6kgDpaL1UQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y+LnX3+vtD1QY5HSDmn0CoSkyXmV8QzD4D8jgR7UwqAsYKEa34chU7L4bVgshgilOf003he4XS8AGADLX/wGb9tX2Xfy94SdUUjQmdrnQoKC1sqlp5abGSmaDL5hna05ZxTSDx/bbBlSMyX7Kje56xeFiumizr1MrnmCnlrZIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZu6wH4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZu6wH4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86EDC4CEC5;
	Wed,  2 Oct 2024 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727861699;
	bh=Sle3Gs+tG1icXE1sGikrBdFltbCO/Av/Z6kgDpaL1UQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TZu6wH4I7vZQ4G784To0fJrCBkWoL5fhyPQMMdnI2VYt0rc5uLl/HZwLhNRpm1pC0
	 aNOonZgn3FeWzhmisQay1Y/t4sI1JTx5RR0J+d/YbFYuxtCUYoWnn/HPz+0RGj07tB
	 DSgTHI62Y9NJ5ok/AsUy73peFaRAgepjEEpznY7ykcR7K+gtq904MQmmxGWk+cd3eH
	 L3gxstZ5X71RCI8s9O6BXQh5mDnInBEE6FE7cjZ/+LBpmPApEDNCK4l99ld4eQ7stH
	 dfJzsviUU6pV+OldD0+AIfjtLL1GHzZZG0sHfAehBmJUXKBBJjR2FUBl04hOHy7yDN
	 YtTO2zVEpOwVQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CB2851200068;
	Wed,  2 Oct 2024 05:34:57 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 05:34:57 -0400
X-ME-Sender: <xms:wRP9Zlxmym9yF8bGEysR15NaGHCFhpATnmmlME3qjJ69GgodKSNx9g>
    <xme:wRP9ZlRZ6t264r3_QWYspZnjei9YLK3v2olsvfIBLhCnTsNB9_zmj_k4486C1rycx
    U7LTLePnv3Y9r0f_uU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhope
    hstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegstggrihhn
    sehquhhitghinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqhhgvgigrghhonhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wRP9ZvXY2TFKYOhKkyg6LNjZJx0xJ9_uVJpAJ3Fmj2vR1LRmLP9S3A>
    <xmx:wRP9ZnjqbK_vr36lnK3k-Q1FILo1W55un0D63oCwBnvIwvJjn6NWbw>
    <xmx:wRP9ZnBp6_7p2tCZApvGxGl-8Nm6EjRIdllUPr0P0AlzhO2DxWWMug>
    <xmx:wRP9ZgIhHd9FqrLzgk-FABhPBKcdq35sAJgm1EKMeT0EOPtRJ3nYqA>
    <xmx:wRP9ZmBrhMdEKBmaaZoulopksB2LAE6O1kanZbDuG5JE4rBs3aLIjgvx>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B8F82220071; Wed,  2 Oct 2024 05:34:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 09:34:37 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Brian Cain" <bcain@quicinc.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <75ea0839-1489-4f49-abcd-104e657a42c5@app.fastmail.com>
In-Reply-To: <72bafe6a2520b976ee99250dd2548a74082796b6.camel@linux.ibm.com>
References: <20240403132447.719833-1-schnelle@linux.ibm.com>
 <20240403132447.719833-2-schnelle@linux.ibm.com>
 <CH3PR02MB10247296630FC062F4E3DE2FDB83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <c04ed601dbd0a8053e034fef1c05ce2ca6e95392.camel@linux.ibm.com>
 <CH3PR02MB10247A45A17F7D8104D1922A8B83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <6c8daef875f9981c59fc5ce9c81eb8c3c2618b5c.camel@linux.ibm.com>
 <CH3PR02MB1024732DF7A1A1FF81535A7D0B8762@CH3PR02MB10247.namprd02.prod.outlook.com>
 <72bafe6a2520b976ee99250dd2548a74082796b6.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without HAS_IOPORT support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 1, 2024, at 08:04, Niklas Schnelle wrote:
> On Mon, 2024-09-30 at 16:35 +0000, Brian Cain wrote:
>> > 
>> > With 2 more of my HAS_IOPORT patches having gone into v6.12-rc1 I just
>> > noticed that this one seems to have fallen into the cracks. This is
>> > probably my fault for not properly confirming that I'd be happy for you
>> > to take it. Do you want me to resend a new version rebased on v6.12-
>> > rc1?
>> 
>> Oh, sorry!  Yes, if you could resend a rebased one I'll make sure I am able to land it.
>> 
>> -Brian
>
> Hi Brian,
>
> I just tried with
>
>    b4 shazam '<20240403132447.719833-2-schnelle@linux.ibm.com>'
>
> and this patch actually still applies cleanly and matches the result I
> got rebasing the whole series[0]. So on second thought taking it from
> here directly might still be the easiest. That said I'll have to send
> out the other 4 outstanding patches required for the final inb()
> compile time switch, so if you prefer I can still resend too.

Hi Niklas,

For simplicity I would suggest you keep all the remaining patches
as a series now and I'll take them through the asm-generic
tree in order to get them in more easily along with the final patch.

      Arnd
