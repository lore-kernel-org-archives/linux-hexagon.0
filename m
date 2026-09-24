Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9724734D0
	for <linux-hexagon@vger.kernel.org>; Thu, 24 Sep 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247864; cv=none; b=O8mPotD3nwF9Ww6dxpOhbjXvT8zVupdAPiLuRA+wxr56iEyc7XXJ8PgyPS/5saxInUlR28EgaM42Hqem41Jd96u/PJwlZhZvzYYh7f1t2AXgzJOyzb/BM9W+fXVrYaX1mQ606CLIx4EiuzgibC6btqro9NRp8IU7LBlpWaQJjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247864; c=relaxed/simple;
	bh=xhb2qZA6d5HWl2ZPK+MdmLz1q3Y5g53VJ1H10PxwQD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cByzdfiHLtqkTFcHpwXQK+qZexaj6YRt5ZO9VJ1jE7D1NuYDSxInAmXz+U6Ev44MIhyQvKmTwpkNT/eOsC/4mmv8mWLjKXXBfUkovT0MYnHzxujhfFaiRwoQ+alnJHvNIM8NZ+Rhq7yaVbBQNDQiRIKIG/6RIxkm3xEPYJQ6ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khEgc5t5; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khEgc5t5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso2447945e9.3
        for <linux-hexagon@vger.kernel.org>; Thu, 24 Sep 2026 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790247861; x=1790852661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2LlYVhm8nVxnFsEgE+UqX+E/pgyRLxWazVBd1Zi8rus=;
        b=khEgc5t50EK43EZuM+DsdFSGx0TbTJqOhAqx+K2C3dksGruQ3pChjSU/CgZ6+c1PiQ
         1b6Af6YBEsMSemOJtCGEzK3AK6KKN9InzcwWkGNKWNn1EgdX1lBchite+luDagGxz6dt
         4IIGAwL02w7TXLsG64nExIkN7EPH/kDpdo73+ot8zrx9ayQh/cSSy4QtPZgMqvGo2Qog
         mHNn0fxy1BmT/RW7UGw28S6tL0hY2o2+XqERIkWGD3+WJL7PN9ZCc9hdzIc/EnqSCRhH
         WH8/xz3g4/IcnpxissQ8mwfoqj11JzGcf78hSVMDsp/Js/s3bPSxWWvHvdt5ot9s+py3
         2jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790247861; x=1790852661;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LlYVhm8nVxnFsEgE+UqX+E/pgyRLxWazVBd1Zi8rus=;
        b=IBRdWLVrr5jBfmJAF6iHMjtk3LqpBd6x1qEiGIMpfKhx05d2IjBiJtq2lMjdvP803z
         fL/12ArmItULiJquWq61Jiyu/HqpfmkWaeHqcZnShpQAoSPjDjjgo7xPeeZ1Wbxj9hgw
         cugl4riK5Qm/zuun0znm+5zjwuIPXBUnFThcyWwEju4z3SaDt56LrZzJCZF+AyP7TK8p
         tCU+ox8jmgCFfXnO19gtySjsOfa7sYehBFtCqqCuMWEy2evusYG3uzsU7tfsKinSgql9
         KNpgKbxn+9gCcqugnPYFaPtYRvlVtDLiY7xUQU/Tdxmk9BRWKCfPRmaPerUygsb3rT2G
         8bgw==
X-Forwarded-Encrypted: i=1; AKwUvByS6fE/K19YOyFaIs1aVW82f3RtYRUkwPcPlS/rAd8tv6m2NUCMUBqslstnw2et3Zkk18SuqGAfv3fU6IDO@vger.kernel.org
X-Gm-Message-State: AFuF++ndVVycWCsDrGaT5ddH6ZRYo9aDR42SCUj5ZBVVwgHsoXDT6YGn
	7R59JS3rWBPpXfh6Zi9dRvyHJuBB+8DMdfGPtioQdMnyVJlgOn+YVRE5
X-Gm-Gg: AYBFou1w3noC+yBTSbDAJj4dxg3YJWag56RTdyw8bZBbMutJmmJhohm3h2jb+6gSR6s
	moTT080XAdQ+6s8mBs7+nHxEsDBwaBkgmp1Y9BKMqQ9u+BPwv4twYQMheVTPQbQD77vlsFf8/oG
	1Zn/TtzAUyicZheulkrbbxKIHJwRTKxujaBNAHCbkAVbkZqh5n0pnoGcfDYBDMDLh/qNYek5J/I
	NigQ2J1Mn3L9iEhkgPex0wVFHyf+0ioHuO9z3HRQGvhpdYlP6uRRdvGnW3CcAWA7r7k3gt7hrau
	8a07b0zDeaqA8ZI2MTURpaaQP0XwLFu4yCb/S7Gl1qFrojSZwIPQ4j933jK9a+bcgrHEAJ4UKzw
	qSAkjz4Smi323oV02A7TCIQNxBpljihgxE9Y/Fii1YJfbuP09jx/yxq3QT67+AZoTBMMYOn48gU
	GHZ+3i7AS6P/xh8LBC7aCYd/KNXASQoyC/RQ9K452YsCU6FIKAyiI4v9UN2Bgyn/2d2rIRS06a+
	rNNwxNqLOrGVqxH8DT67iqfKBcLq7dfRKNRDW8ixrkGcg==
X-Received: by 2002:a05:600c:a00b:b0:49c:cee2:a508 with SMTP id 5b1f17b1804b1-49fe66eaff3mr30308125e9.16.1790247860870;
        Thu, 24 Sep 2026 04:04:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm77122275e9.3.2026.09.24.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:04:20 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:04:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 pierrick.bouvier@oss.qualcomm.com, paulmck@kernel.org,
 sid.manning@oss.qualcomm.com, linux-hexagon@vger.kernel.org, Ingo Molnar
 <mingo@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2] smp: align struct __call_single_node to 8 bytes
Message-ID: <20260924120419.6cefb60d@pumpkin>
In-Reply-To: <20260924093450.GN2009045@noisy.programming.kicks-ass.net>
References: <20260923154307.3625611-1-brian.cain@oss.qualcomm.com>
	<20260924093450.GN2009045@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 11:34:50 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 23, 2026 at 08:43:07AM -0700, Brian Cain wrote:
> > Consumers walking call_single_queue cast each node to call_single_data_t
> > and, given that type's declared over-alignment, the compiler may load
> > llist.next and u_flags as one naturally aligned double word.  Fields using
> > this type, such as task_struct::wake_entry only guarantee pointer alignment,
> > which faults on strict-alignment 32-bit architectures like hexagon.  
> 
> Where exactly does this happen? I'm failing with grep.
> 

Here for one:

void __smp_call_single_queue(int cpu, struct llist_node *node)
{
	/*
	 * We have to check the type of the CSD before queueing it, because
	 * once queued it can have its flags cleared by
	 *   flush_smp_call_function_queue()
	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
	 * executes migration_cpu_stop() on the remote CPU).
	 */
	if (trace_csd_queue_cpu_enabled()) {
		call_single_data_t *csd;
		smp_call_func_t func;

		csd = container_of(node, call_single_data_t, node.llist);
		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
			sched_ttwu_pending : csd->func;

		trace_call__csd_queue_cpu(cpu, _RET_IP_, func, csd);
	}

since the data item itself was probably created with:

#define CSD_INIT(_func, _info) \
	(struct __call_single_data){ .func = (_func), .info = (_info), }

I've not looked hard enough to see what the extra alignment was trying
to achieve.
But the above function needs to use the 'less aligned' struct __call_single_data
even if some places use call_single_data_t to get a 'more aligned' structure.

David
