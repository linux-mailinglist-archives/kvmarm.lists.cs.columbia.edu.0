Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3547BE7B
	for <lists+kvmarm@lfdr.de>; Tue, 21 Dec 2021 11:54:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B394B4B104;
	Tue, 21 Dec 2021 05:54:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@os.amperecomputing.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AH6uYqTdlYuW; Tue, 21 Dec 2021 05:54:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C7E34B0EC;
	Tue, 21 Dec 2021 05:54:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 860B940B41
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Dec 2021 05:12:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFVP23x8j4hQ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Dec 2021 05:12:48 -0500 (EST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 647EB402DB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Dec 2021 05:12:48 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeG5lwkjfAhxIEUIWL4ho2R5tAmI+UlGq/TziKHptisQkVyUGSni+vlrjkiCsgpcR1e8KusWrCeug0tUH0BCNdhKJewYxaU+nGIKzw2tKlGJI2qAFKyQHb56FiGg0hDZkbgJMG/IPzwzE1RQ9KuaKl8gxQrkNLDTgOPTtQ+cU9XtEOilVGRIkWk+F0s7156PhNSoDlgJoQAHEfGsqYON4LojdX/j8uprhN5bthsAtnW+p27WBsOBadTWBlGzCuRFO1Hz7cfGfIhnavq9l/syyhLsWCnxm7/Luzd8w8nqqrrdEf4M4SWQc3/68QEOb/x01zo7JPDjAx/OXo2ELQrC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSdnNkB3BFKZ8qoSMdL5FVAHLA2svPbUsRPt0ZnHdss=;
 b=kKHtPS2yTYXqegyJDX4Itthp9EpcZ6lYDrHz8REyMPI8pus2Pabm5cMhICDubevsqE5nUGwaOegTa+6nfq2UE+cQDNPvd7jgV1oSC0vuxbUb9f92nFDxyvw492YYD2T7hSEBMxg9oDjrEXj3P48hZZNiguCPlh5PpQd8DTVEpHLVPnZ3ca0IUNM8dUPsO0w6k6Ugkc/AfQIHb0BXOpnQsd6In89W919myVB/Yiw0XusEbJnfACQUc+MJB+RkdC6KqUhctfl8ylc0B093w0Klw1gai1eUF+4tB9XZTQwWpscddQiAJGmkJq7bxV8CEiRo0f3Czxr8iWHT0GNv+1iaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSdnNkB3BFKZ8qoSMdL5FVAHLA2svPbUsRPt0ZnHdss=;
 b=P8I29pYAlfF7Ub2JQVPlH3fENDC2VnsZbq2+vDtklJAbyhA2791wXX0Ld/p9Im300E2b6yWmDW3o/9RvVtsa8uczyts1qeH3M28H36xxU0xMFj8lT7+iuQ9ucBkjSNjWAIp9uCXiDBX47rtPUprRZmlzFNiCvDA71l62N3RLASw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM8PR01MB7159.prod.exchangelabs.com (2603:10b6:8:d::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Tue, 21 Dec 2021 10:12:45 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::209e:941a:d9f9:354e]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::209e:941a:d9f9:354e%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 10:12:45 +0000
Message-ID: <26b27c3d-7e05-9784-38b3-a7af944b5625@os.amperecomputing.com>
Date: Tue, 21 Dec 2021 15:42:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 18/69] KVM: arm64: nv: Handle virtual EL2 registers in
 vcpu_read/write_sys_reg()
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
References: <20211129200150.351436-1-maz@kernel.org>
 <20211129200150.351436-19-maz@kernel.org>
 <13046e57-b7e5-7f0b-15bd-38c09e21807a@os.amperecomputing.com>
 <87lf0fwsj5.wl-maz@kernel.org>
 <ccfc064b-55d1-470d-5815-94935e785279@os.amperecomputing.com>
 <871r26wdup.wl-maz@kernel.org>
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <871r26wdup.wl-maz@kernel.org>
X-ClientProxiedBy: CH0PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:610:75::33) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95461d5f-b3e8-40df-233a-08d9c46a6eb0
X-MS-TrafficTypeDiagnostic: DM8PR01MB7159:EE_
X-Microsoft-Antispam-PRVS: <DM8PR01MB71594F6DBBAB708CE9B6BA2E9C7C9@DM8PR01MB7159.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bgsdu+8METKaLLbtu2+YmYA9Dy09HZGFgI56XZJhN9WGfB1DyEBqEOA9UEDfnnxcVQWSz0j4nE7I7ORfa0RGf7X4mPgUQ0TXjbYPrYdr0AlM2BYUprqpfggAkQcei/haS4JprvIpG+pDA4eqoywlUWoqJjmSCu7Jw1eLkt2TMoSiIBQV5HDkeU7L8blFvZiqN0wswN19TUeiIe9S8/OyjErbEwe/WBTI6mrGvNcXaf2W2MlX28uBMqABohbwH5HqTGxpdp/nVs0d7dyK5Mzv8Yf8JMvEs/gUKmpfUdsGcYeF2zd/PMuwmmi9jKT8fIhT0e5EGMrEJnYkdElby187SeBYA2DH/3XgjUhOz5FruuFhP+9Qa/YNYpdAS83mg4dqUys5s9qj0UF2/FS98RnEZWJinl2bq71vHT2dX6zEjvSzPkxHw9pphDNVBwFRVSrmeh7DS6WbUTV3DD5VermBbyBV0hFK+4LRZsD2aGVPYPw0R11ayzRS2vG5U+QwYvoqgZA1YWoO0pmiGsnPKznBQ5bIUWsF+1yYGcqPn9bcrno9HtjgHHjOTVfw/vCZLidYL+f+kGiCGsxHyocJtuW5EbIXfRQWCNGgqDT3gSu2UMx5FJvrtOm/nIIbENB0EyCsMz3E/Vx6XKCDqeYh2f35eNqlDgdSJX448Ozhn0igulfd1f5Slor90fRZPgPuDQfmNfJrqDmQIQo6DIJXyo10WYM7+lqTwdAdwk2F2vT8uVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB6824.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31686004)(66556008)(31696002)(54906003)(6486002)(6512007)(7416002)(2906002)(26005)(8936002)(6506007)(55236004)(316002)(6916009)(53546011)(52116002)(66476007)(508600001)(83380400001)(8676002)(66946007)(5660300002)(4326008)(6666004)(38100700002)(38350700002)(2616005)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG1yQ3p5czFHL0N4K2VPY09FcDQyYWFGNzd4NEhxVXBmWUk5SkNxK0gxZjUz?=
 =?utf-8?B?eEVYaE5BVkZRS0pZRmJxNCtaTi9SVFJvMjFlMHI5eGdPZlRNcXpwQ0xDOEZU?=
 =?utf-8?B?SzZCUkNJclliZktLRkhycnE0Z1Jad1I0enh1ZlQ3Q2Y1TUZ5WGl4WkQ0MWlh?=
 =?utf-8?B?a3R3N0JyMlNZaEJMQmF5VnV2OGNWV1BUc3R3aUJNVXV4Y2dkYUxMdUhmMmhj?=
 =?utf-8?B?ZnZXeElUVUhRRksrSE43V3QvYTJyOFVCWWdLMk5GVW51WDM2aFpnWWxlekIr?=
 =?utf-8?B?L2JCUkJKVjM2MWg4M3R6YmVlajE5UG5Tb1k4Rk14S2FZZnVCVnBLS3pTdEk1?=
 =?utf-8?B?dWFFd0tSTUpjSlBheHV3MWJKNHhVQXdTa2gwNnhRWUxlQW5yajRiNGJvUHNs?=
 =?utf-8?B?b3ZDWWhNTFM4NU1wSkV3VitLWVRKalhJSzRyazMvSWlZbEJScnk3Zi9IVExv?=
 =?utf-8?B?SzV3THhzUWtnaHBScVBvdUVhTlUxZnltZzB1U2RmT1AybS81MkFxZDhBZjRP?=
 =?utf-8?B?dzU0amZNTVk3WW9WczAyckVITHgwRUNySlczWEVncjNOK2pCSDgwcUR0dGVx?=
 =?utf-8?B?RkpRSytONzhEVEhIbm5jc1FoZTJGT3Y3NHViQ0VWYlB5aVJxNHF4bDNHQzVE?=
 =?utf-8?B?Z29Hekg0M0ZZT0dVOVNOR0Zzelo5VngzNFdGMGc1K2R4RnJoR0pzVHhtR1c4?=
 =?utf-8?B?VTlPUkt4K0NWaFJXcHZmeHBVc3poWHRyZ2RnYThQZnY2elVVbVZXOXlmM2tk?=
 =?utf-8?B?NEhHVXFlYkdBc2cyOFJNL3ZVNUFYMnRELytLUEE0S1dLN3N3MXo5TThRczZk?=
 =?utf-8?B?eHFqQk1NSXBJcStDY3pLZTI1YTdNMTFrSW1EaUdvb2pKcjYvM1pUL3NzVC9y?=
 =?utf-8?B?SnZGeXJjWjYzbmdSN0ZjMDc4WEpOMUNBNUlxQU1EbUViWG0xZW5BOGdXQ2JW?=
 =?utf-8?B?VjBTYUdrVzFVaU5wSkJRTkR3S2hXRzR5bWdXd1NqTUdGdS9qVHhaWWxKNlZE?=
 =?utf-8?B?K0VucUtzOGxsajFNRG5KZTRoYzFkWXQwMld6SlBNcWFiNTJRNVV1SHVQMWlj?=
 =?utf-8?B?NWM5YjNiY3BINEIzWWY1Nmw5S2Z4bkM0U3hXbXRHUDFTeXIzYUM0U2M0cVZC?=
 =?utf-8?B?dGcraWJnNUd0dkFpVXREUHhOTGUwaG8xNjY5UzVhQkprQmVvdUtKTlJGbmpz?=
 =?utf-8?B?VHJZU1dFZ2tzSWRPRC8wdFVUV1JnbmxuSFY3aW02eWRjS0VhZ3VBajRROFBW?=
 =?utf-8?B?SUNya21OVWgwbVRBTzRvMEE0VkFTUmcxZjdBMUZ5TmFiZmNVNFJZcGVZZElG?=
 =?utf-8?B?WlBtR0J4RklGTlRwMVp1OEJDQmJLeUxxU1hNWWJ5Z1dLSktVclh6c2MycWZs?=
 =?utf-8?B?QTFDNEJRbm5wOUtuSHNvWFVkZnJhUnAwc3IzRFNCWHFPbTc5eENmdUs4QnNO?=
 =?utf-8?B?aDcyR3FVQWd1M2JyQXpMYWJBdEpWM20xd3pWM2JRbS9sVzJ4YU1IVVdjc3lT?=
 =?utf-8?B?RURCTW5pSUVrbm8xbytzUVlGdkEvWWgwSDIyV3hZOU5wSFlmS0JoNGdva2Jh?=
 =?utf-8?B?bjk4dUlnaHVsT0NXVUFveVVsK2dYOHdzU0g3enhZM1BNY3htWFlPT1Jhd3Ny?=
 =?utf-8?B?bWgrR2FXQ0ZSblhKR3lPUVhJWFovbnZmZlJ4TS9oeVRESE96NFBOWGJFL3Ns?=
 =?utf-8?B?VXh4c1lXZDJWWFhvdjF4bi8vc0t4cVk4WE9Dc3RjMkRmUllSY0JsZVVGcGJE?=
 =?utf-8?B?ZVhzUC9XQ25nSFNncEV5c2ZSMURISXpwTVcxOWt4OGgweHBPd0EyRTVLUHVs?=
 =?utf-8?B?TGtUUEs2ZlFkbmV5MXdYcVM0TE9vQ0VwUndBZXdhWTFRUloyaGt0RHRiQ0tn?=
 =?utf-8?B?M2FrS2hpYURKZFZlMzBxU1l6RGpYamJlb2YrRjNZR0FwOVYxYVpwUzZIRkZZ?=
 =?utf-8?B?alRqSW0xQXlGdkRDMXhtdDFmY0JmekV5UDdleis4RlN3WkFzZVlMd1dGYm5y?=
 =?utf-8?B?c01BdytRbXptWDFRSU42MU1mMFJaRVZrbllLT1VlUjBUK0VxbWhOSUJSUzBK?=
 =?utf-8?B?L0laTFdLYWlNcXEzck1HeXhkcmpyQzlYckRGZmZDc1c2MWM3SVBaaHdRb0Rh?=
 =?utf-8?B?azJMMWI4bWxQVlJyZXdiZkowL2dSbUoxL2NUV0VUOGpXQThvdGorQzhGTlFq?=
 =?utf-8?B?NklpUjdKQWpFdGp5d1gxR3ZtYkoycStTN0VGMCs3Tk5pUjJPUnR1TUwwTTlB?=
 =?utf-8?B?S2lnUUFqRTVqMlhKa0dCNG9RK3FpMEExRU9IdFpwdmhSYVBoUGFqUGMvQlFV?=
 =?utf-8?B?NEhVL2VCclFiTGZSeldxdTkzU1ZDSTBUMFJGYlFzQmJ2ZHZMNngxZz09?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95461d5f-b3e8-40df-233a-08d9c46a6eb0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 10:12:45.3500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8vTd5H1nI7kOl6UJ2C5GlvjYINI2LatfvHP9xpK9VdmtUSdsdOzWKfIUwGqTOIX5bKN3L8cRcc+97GRl5akPXiggA0r6zGdowwG8m3Qj6J7b8aJVxe5thh1sSwL1oF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7159
X-Mailman-Approved-At: Tue, 21 Dec 2021 05:54:07 -0500
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu



On 21-12-2021 02:09 pm, Marc Zyngier wrote:
> On Tue, 21 Dec 2021 07:12:36 +0000,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>>
>>
>> On 20-12-2021 02:40 pm, Marc Zyngier wrote:
>>> On Mon, 20 Dec 2021 07:04:44 +0000,
>>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>>
>>>>
>>>> On 30-11-2021 01:30 am, Marc Zyngier wrote:
>>>>> KVM internally uses accessor functions when reading or writing the
>>>>> guest's system registers. This takes care of accessing either the stored
>>>>> copy or using the "live" EL1 system registers when the host uses VHE.
>>>>>
>>>>> With the introduction of virtual EL2 we add a bunch of EL2 system
>>>>> registers, which now must also be taken care of:
>>>>> - If the guest is running in vEL2, and we access an EL1 sysreg, we must
>>>>>      revert to the stored version of that, and not use the CPU's copy.
>>>>> - If the guest is running in vEL1, and we access an EL2 sysreg, we must
>>>>
>>>> Do we have vEL1? or is it a typo?
>>>
>>> Not a typo, but only a convention (there is no such concept in the
>>> architecture). vELx denotes the exception level the guest thinks it is
>>> running at while running at EL1 (as it is the case for both vEL1 and
>>> vEL2).
>>>
>>
>> OK got it, this is to deal with Non-VHE case.
> 
> No, you'd have the exact same thing with a VHE guest itself running an
> EL1 guest. You really cannot distinguish the two cases.
> 
Okay understood, thanks.

> In general, you can't really think the NV support in terms of VHE or
> nVHE, or even in terms of guest level. You need to think in terms of a
> single machine with three exception levels, and follow the rules of
> the architecture to the letter.

OK.
> 
> Thanks,
> 
> 	M.
> 

Thanks,
Ganapat
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
