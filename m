Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3596D1F1B6F
	for <lists+kvmarm@lfdr.de>; Mon,  8 Jun 2020 16:51:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92ED54B1B7;
	Mon,  8 Jun 2020 10:51:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-AIL00xY6EY; Mon,  8 Jun 2020 10:51:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 69DF94B1B9;
	Mon,  8 Jun 2020 10:51:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 12BAC4B1A9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 10:51:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VeJ6Zla1GHXH for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Jun 2020 10:51:52 -0400 (EDT)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0552A4B151
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 10:51:52 -0400 (EDT)
Received: by mail-wr1-f67.google.com with SMTP id l11so17739730wru.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 08 Jun 2020 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=09t4vJAEJNOcAKbjc/XrD7rKiwG3r51o8wQyvTLcyH8=;
 b=H0W6Kxn1tWB0Gd5mhqe5+76N1JoRrfQBzuFyeHyKdKuKr3c0mxvi1yAFcfLLIJyh55
 0k8dOPOj9CmK+GRAegeskyYIv+TKDj2iQeUXFmB0nzECSIxyFfzhVJWU9aWVBdTEchFP
 GlzcpS27DdL03xE79FQZzpNvHLcxsYPNwzcAPR76BqA9jTXdUk/YUdxlqW4FAdbBRwNf
 larkyRCJnjdssMA6KHO2gAUNviKrbJ7XhB3sWo/Wp1musUseGP2k62qvdmy2yuoLieci
 tP3J5viTXpUZQyvmoWug1BfYa6vn0NDeWQAQ07YD0Y4SXO0NCVrrvhcExX8dj7+yQfL9
 PSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=09t4vJAEJNOcAKbjc/XrD7rKiwG3r51o8wQyvTLcyH8=;
 b=ZYHxkZJO6XCIdo0/S8tVvwOq2295mahq5XELuztuGVxWfNwRKr4EBxCRfoSkIC2DeG
 wR8T9DCn221N0Zpgh1zU0e8Np0ve1e9/+NyZPf04PFEwL0pL6tenJ5yMDqljzKbQKWxQ
 cmTqzKLh81aHM94rgk4lCosdvOdMvrEFRW1hzvKLR5uiCPhY8RZuDzIrxBl9Ur2UnCjt
 6KyaQ3tToaakgvKWBSUX+sg+RwY1OW737R3O7DI2Rr5JDb0viNpZ98hAf8JjjuK/+rni
 /zZxuOW1LWvlAJS/ExBBANhzPbKN6Z3Kbi9MiNW+XlBa8tO20xNbek/64gnHPstkZQZY
 vVKQ==
X-Gm-Message-State: AOAM533qsLnE13sDHWvpY9ekgkXDT2K9rUN1AiaGye+qQeCSFaD5Giam
 6uJlZftPAHbyn3iutox3cK25xQ==
X-Google-Smtp-Source: ABdhPJw/eKBztQ3a9E6WKUS5WsHzaQqYg5KTtA62h7WxrR2Vb+QDhRKkaSCaXQP78CvwMVocDYT20A==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr25577401wrv.207.1591627910886; 
 Mon, 08 Jun 2020 07:51:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
 by smtp.gmail.com with ESMTPSA id c5sm19131623wma.20.2020.06.08.07.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 07:51:50 -0700 (PDT)
Date: Mon, 8 Jun 2020 15:51:45 +0100
From: Andrew Scull <ascull@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: Remove host_cpu_context member from vcpu
 structure
Message-ID: <20200608145145.GA96714@google.com>
References: <20200608085657.1405730-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200608085657.1405730-1-maz@kernel.org>
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, Jun 08, 2020 at 09:56:57AM +0100, Marc Zyngier wrote:
> For very long, we have kept this pointer back to the per-cpu
> host state, despite having working per-cpu accessors at EL2
> for some time now.
> 
> Recent investigations have shown that this pointer is easy
> to abuse in preemptible context, which is a sure sign that
> it would better be gone. Not to mention that a per-cpu
> pointer is faster to access at all times.

Helps to make the references to `kvm_host_data` clearer with there now
being just one way to get to it and shows that it is scoped to the
current CPU. A good change IMO!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
